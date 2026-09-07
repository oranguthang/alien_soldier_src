Projectile_Epsilon1SpreadInit:                          ; DATA XREF: Boss_Epsilon1DefeatInit   o  ; was: sub_470C2
                movea.w a5,a0
                move.w  #5,$4A(a0)
                bra.s   loc_470D4
; End of function Projectile_Epsilon1SpreadInit
; Expanding spread projectile with deceleration
Projectile_Epsilon1SpreadExpanding:                     ; DATA XREF: Projectile_Epsilon1SpreadSetup   o  ; was: sub_470CC
                movea.w a5,a0
                move.w  #$B,$4A(a0)
loc_470D4:                                              ; CODE XREF: Projectile_Epsilon1SpreadInit+8   j
                move.w  #$27C,(a0)
                move.w  #$44F1,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #$8C80,2(a0)
                move.w  #$C8,$26(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.l  #$FC04FC04,$2C(a0)
                move.w  #2,$48(a0)
                lea     (word_1B514).l,a2
                move.w  $58(a0),d0
                andi.w  #$1FE,d0
                move.w  -$80(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                ext.l   d0
                ext.l   d1
                asl.l   #6,d0
                asl.l   #6,d1
                move.l  d0,$18(a0)
                move.l  d1,$1C(a0)
                neg.l   d0
                neg.l   d1
                move.l  d0,$4C(a0)
                move.l  d1,$50(a0)
                move.l  d0,$54(a0)
                move.l  d1,$58(a0)
                rts
; End of function Projectile_Epsilon1SpreadExpanding
; Defeat debris projectiles
Projectile_Epsilon1DefeatDebris:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_47146
                bsr.w   Boss_Epsilon1CheckVulnerable
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$5C(a5)
                cmpi.w  #$150,$14(a5)
                bcc.w   Projectile_Epsilon1SpreadUpdate
                cmpi.w  #$20,$14(a5)                    ; ' '
                bls.w   Projectile_Epsilon1SetFlag
                cmpi.w  #$1D0,$5C(a5)
                bhi.w   Projectile_Epsilon1SetFlag
                cmpi.w  #$70,$5C(a5)                    ; 'p'
                bcs.w   Projectile_Epsilon1SetFlag
                tst.w   $5E(a5)
                beq.w   loc_4718C
                move.w  #4,4(a5)
loc_4718C:                                              ; CODE XREF: Projectile_Epsilon1DefeatDebris+3C   j
                move.w  4(a5),d0
                lea     off_47198(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1DefeatDebris
; ---------------------------------------------------------------------------
off_47198:      dc.w    Projectile_Epsilon1SpreadDelayTimer-*  ; DATA XREF: Projectile_Epsilon1DefeatDebris+4A   o
                dc.w    Projectile_Epsilon1SpreadSpawn-*
                dc.w    Gfx_Epsilon1SpreadAnimateCycle-*

; Decrements timer and advances when expired
Projectile_Epsilon1SpreadDelayTimer:                    ; DATA XREF: ROM:off_47198   o  ; was: sub_4719E
                subq.w  #1,$48(a5)
                bne.s   locret_471A8
                addq.w  #2,4(a5)
locret_471A8:                                           ; CODE XREF: Projectile_Epsilon1SpreadDelayTimer+4   j
                rts
; End of function Projectile_Epsilon1SpreadDelayTimer
; Spawns spread projectile with position offset
Projectile_Epsilon1SpreadSpawn:                         ; DATA XREF: ROM:0004719A   o  ; was: sub_471AA
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4721E
                move.w  #1,$5E(a0)
                move.w  #$27C,(a0)
                move.w  #$44F1,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #$8CC0,2(a0)
                move.l  #$FC04FC04,$2C(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  $18(a5),$18(a0)
                move.l  $1C(a5),$1C(a0)
                move.l  $4C(a5),d0
                add.l   d0,$10(a0)
                move.l  $50(a5),d1
                add.l   d1,$14(a0)
                move.l  $54(a5),d0
                add.l   d0,$4C(a5)
                move.l  $58(a5),d1
                add.l   d1,$50(a5)
                subq.w  #1,$4A(a5)
                bne.s   locret_4721E
                addq.w  #2,4(a5)
locret_4721E:                                           ; CODE XREF: Projectile_Epsilon1SpreadSpawn+6   j
                                        ; Projectile_Epsilon1SpreadSpawn+6E   j
                rts
; End of function Projectile_Epsilon1SpreadSpawn
; Cycles through animation frames modulo 4
Gfx_Epsilon1SpreadAnimateCycle:                         ; DATA XREF: ROM:0004719C   o  ; was: sub_47220
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                beq.s   locret_4724C
                cmpi.w  #1,d0
                beq.s   loc_47246
                cmpi.w  #2,d0
                beq.s   loc_4723E
                move.w  #$44F7,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_4723E:                                              ; CODE XREF: Gfx_Epsilon1SpreadAnimateCycle+14   j
                move.w  #$44F6,$E(a5)
                rts
; ---------------------------------------------------------------------------
loc_47246:                                              ; CODE XREF: Gfx_Epsilon1SpreadAnimateCycle+E   j
                move.w  #$44F1,$E(a5)
locret_4724C:                                           ; CODE XREF: Gfx_Epsilon1SpreadAnimateCycle+8   j
                rts
; End of function Gfx_Epsilon1SpreadAnimateCycle
; Spread shot pattern movement
Projectile_Epsilon1SpreadUpdate:                        ; CODE XREF: Projectile_Epsilon1DefeatDebris+16   j  ; was: sub_4724E
                clr.b   $21(a5)
                move.l  #off_E95DC,8(a5)
                jsr     (Projectile_InitType88FromCurrent).l
                clr.l   $18(a5)
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,$18(a5)
                bsr.s   Projectile_Epsilon1CheckFlag
                tst.w   $5E(a5)
                bne.s   locret_4729E
                addq.w  #2,(word_FFA010).w
                tst.w   $5E(a5)
                bne.w   locret_4729E
                move.b  #$E1,d0
                jsr     (Sound_PlaySFX).l
locret_4729E:                                           ; CODE XREF: Projectile_Epsilon1SpreadUpdate+38   j
                                        ; Projectile_Epsilon1SpreadUpdate+42   j
                rts
; End of function Projectile_Epsilon1SpreadUpdate
; Sets flag $1000 in projectile flags and chains to handler
Projectile_Epsilon1SetFlag:                             ; CODE XREF: Projectile_Epsilon1DefeatDebris+20   j  ; was: sub_472A0
                                        ; Projectile_Epsilon1DefeatDebris+2A   j
                move.w  #$1000,2(a5)
                bsr.s   Projectile_Epsilon1CheckFlag
locret_472A8:                                           ; CODE XREF: Boss_Epsilon1SpawnProjectile+6   j
                rts
; End of function Projectile_Epsilon1SetFlag
; Tests and clears projectile flag bit #4 in entity
Projectile_Epsilon1CheckFlag:                           ; CODE XREF: Projectile_Epsilon1SpreadUpdate+32   p  ; was: sub_472AA
                                        ; Projectile_Epsilon1SetFlag+6   p
                tst.w   (dword_FF9420).w
                beq.s   locret_472BE
                movea.w (dword_FF9420).w,a0
                bset    #4,2(a0)
                clr.w   (dword_FF9420).w
locret_472BE:                                           ; CODE XREF: Projectile_Epsilon1CheckFlag+4   j
                rts
; End of function Projectile_Epsilon1CheckFlag
; Projectile main handler
Projectile_Epsilon1IntroMain:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_472C0
                bsr.w   Boss_Epsilon1CheckVulnerable
                move.w  4(a5),d0
                lea     off_472D0(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1IntroMain
; ---------------------------------------------------------------------------
off_472D0:      dc.w    Projectile_Epsilon1SetTimer-*   ; DATA XREF: Projectile_Epsilon1IntroMain+8   o
                dc.w    Projectile_Epsilon1CountdownTimer-*
                dc.w    Projectile_Epsilon1SpawnPattern-*
                dc.w    Projectile_Epsilon1Cleanup-*

; Sets initial timer
Projectile_Epsilon1SetTimer:                            ; DATA XREF: ROM:off_472D0   o  ; was: sub_472D8
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Projectile_Epsilon1SetTimer
; Counts down timer
Projectile_Epsilon1CountdownTimer:                      ; DATA XREF: ROM:000472D2   o  ; was: sub_472E4
                subq.w  #1,$48(a5)
                bne.s   locret_472F4
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_472F4:                                           ; CODE XREF: Projectile_Epsilon1CountdownTimer+4   j
                rts
; End of function Projectile_Epsilon1CountdownTimer
; Spawns multiple projectiles in pattern
Projectile_Epsilon1SpawnPattern:                        ; DATA XREF: ROM:000472D4   o  ; was: sub_472F6
                eori.w  #$8000,2(a5)
                subq.w  #1,$48(a5)
                bne.s   locret_47348
                move.w  #7,d7
                move.w  #$60,d6                         ; '`'
                clr.w   d5
loc_4730C:                                              ; CODE XREF: Projectile_Epsilon1SpawnPattern+34   j
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   loc_4732E
                bsr.s   Projectile_Epsilon1InitProperties
                move.w  $10(a5),$10(a0)
                move.w  d6,$14(a0)
                move.w  d5,$5E(a0)
                addq.w  #1,d5
                subi.w  #$20,d6                         ; ' '
                dbf     d7,loc_4730C
loc_4732E:                                              ; CODE XREF: Projectile_Epsilon1SpawnPattern+1C   j
                move.w  #$10,$48(a5)
                ori.w   #$8000,2(a5)
                addq.w  #2,4(a5)
                move.b  #$AB,d0
                jsr     (Sound_PlaySFX).l
locret_47348:                                           ; CODE XREF: Projectile_Epsilon1SpawnPattern+A   j
                rts
; End of function Projectile_Epsilon1SpawnPattern
; Initializes projectile properties
Projectile_Epsilon1InitProperties:                      ; CODE XREF: Projectile_Epsilon1SpawnPattern+1E   p  ; was: sub_4734A
                move.w  #$280,(a0)
                move.w  #$8D80,2(a0)
                move.w  #$43D2,$E(a0)
                move.w  #$300,8(a0)
                move.w  #$FCF0,$A(a0)
                move.w  #$C,$1C(a0)
                move.w  #$14,$48(a0)
                rts
; End of function Projectile_Epsilon1InitProperties
; Timer countdown with cleanup
Projectile_Epsilon1Cleanup:                             ; DATA XREF: ROM:000472D6   o  ; was: sub_47374
                subq.w  #1,$48(a5)
                bne.s   locret_47380
                bset    #4,2(a5)
locret_47380:                                           ; CODE XREF: Projectile_Epsilon1Cleanup+4   j
                rts
; End of function Projectile_Epsilon1Cleanup
; Projectile state handler
Projectile_Epsilon1StateHandler:                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_47382
                cmpi.w  #$150,$14(a5)
                bgt.w   Projectile_Epsilon1OffscreenHandler
                move.w  4(a5),d0
                lea     off_47398(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1StateHandler
; ---------------------------------------------------------------------------
off_47398:      dc.w    Projectile_Epsilon1DescentState-*  ; DATA XREF: Projectile_Epsilon1StateHandler+E   o
                dc.w    Projectile_Epsilon1AnimationState-*
                dc.w    nullsub_91-*

; Projectile descent state
Projectile_Epsilon1DescentState:                        ; DATA XREF: ROM:off_47398   o  ; was: sub_4739E
                subq.w  #1,$48(a5)
                bne.s   locret_473C6
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
                move.w  #4,$48(a5)
                move.b  #$40,$21(a5)                    ; '@'
                move.l  #$F808F010,$2C(a5)
                move.w  #$C8,$26(a5)
locret_473C6:                                           ; CODE XREF: Projectile_Epsilon1DescentState+4   j
                rts
; End of function Projectile_Epsilon1DescentState
; Projectile animation state
Projectile_Epsilon1AnimationState:                      ; DATA XREF: ROM:0004739A   o  ; was: sub_473C8
                subq.w  #1,$48(a5)
                bne.s   locret_47406
                move.w  #2,$48(a5)
                addq.w  #2,$5C(a5)
                cmpi.w  #$10,$5C(a5)
                bls.s   loc_473F0
                clr.b   $21(a5)
                move.w  #$10,$1C(a5)
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_473F0:                                              ; CODE XREF: Projectile_Epsilon1AnimationState+16   j
                move.w  $5C(a5),d0
                move.w  word_47408(pc,d0.w),$E(a5)
                move.w  word_4741A(pc,d0.w),8(a5)
                move.w  word_4742C(pc,d0.w),$A(a5)
locret_47406:                                           ; CODE XREF: Projectile_Epsilon1AnimationState+4   j
                rts
; End of function Projectile_Epsilon1AnimationState
; ---------------------------------------------------------------------------
word_47408:     dc.w    $43D2, $43D6, $43DA, $43EA, $43E2, $43EA, $43DA, $43D6, $43D2
                                        ; DATA XREF: Projectile_Epsilon1AnimationState+2C   r
word_4741A:     dc.w    $300, $300, $700, $700, $700, $700, $700, $300, $300
                                        ; DATA XREF: Projectile_Epsilon1AnimationState+32   r
word_4742C:     dc.w    $FCF0, $FCF0, $F8F0, $F8F0, $F8F0, $F8F0, $F8F0, $FCF0, $FCF0
                                        ; DATA XREF: Projectile_Epsilon1AnimationState+38   r

nullsub_91:                                             ; DATA XREF: ROM:0004739C   o
                rts
; End of function nullsub_91

; Projectile offscreen handler
Projectile_Epsilon1OffscreenHandler:                    ; CODE XREF: Projectile_Epsilon1StateHandler+6   j  ; was: sub_47440
                move.l  #off_E95DC,8(a5)
                jsr     (Projectile_InitType88FromCurrent).l
                clr.l   $18(a5)
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,$1C(a5)
                move.w  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #7,d0
                subq.w  #4,d0
                add.w   d0,$18(a5)
                tst.w   $5E(a5)
                bne.s   locret_47484
                move.w  #2,(word_FFA010).w
                move.b  #$E1,d0
                jsr     (Sound_PlaySFX).l
locret_47484:                                           ; CODE XREF: Projectile_Epsilon1OffscreenHandler+32   j
                rts
; End of function Projectile_Epsilon1OffscreenHandler
; Chain projectile initialization
Projectile_Epsilon1ChainInit:                           ; DATA XREF: ROM:off_5DC   o  ; was: sub_47486
                btst    #0,(word_FFC66C).w
                bne.s   loc_4749C
                btst    #2,(word_FFC66C).w
                beq.s   loc_474E6
                clr.w   4(a5)
                bra.s   loc_474AA
; ---------------------------------------------------------------------------
loc_4749C:                                              ; CODE XREF: Projectile_Epsilon1ChainInit+6   j
                cmpi.w  #$C,4(a5)
                bcc.s   loc_474E6
                move.w  #$C,4(a5)
loc_474AA:                                              ; CODE XREF: Projectile_Epsilon1ChainInit+14   j
                andi.w  #$7FFF,2(a5)
                tst.w   $4E(a5)
                movea.w $4E(a5),a0
                beq.s   loc_474E6
                jsr     (Projectile_InitType88).l
                move.l  #off_E953C,8(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  2(a5),d0
                andi.w  #$8000,d0
                andi.w  #$7FFF,2(a0)
                or.w    d0,2(a0)
loc_474E6:                                              ; CODE XREF: Projectile_Epsilon1ChainInit+E   j
                                        ; Projectile_Epsilon1ChainInit+1C   j
                move.w  4(a5),d0
                lea     off_474F2(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_Epsilon1ChainInit
; ---------------------------------------------------------------------------
off_474F2:      dc.w    nullsub_92-*                    ; DATA XREF: Projectile_Epsilon1ChainInit+64   o
                dc.w    Projectile_Epsilon1ChainSegment-*
                dc.w    Projectile_Epsilon1RingInit-*
                dc.w    Projectile_Epsilon1BurstInit-*
                dc.w    Projectile_Epsilon1TrackingInit-*
                dc.w    Projectile_Epsilon1TrackingUpdate-*
                dc.w    nullsub_93-*
                dc.w    Effect_Epsilon1DefeatSpark2-*
                dc.w    Effect_Epsilon1DefeatSpark4-*
                dc.w    Projectile_Epsilon1Despawn-*

nullsub_92:                                             ; DATA XREF: ROM:off_474F2   o
                rts
; End of function nullsub_92

; Chain segment physics
Projectile_Epsilon1ChainSegment:                        ; DATA XREF: ROM:000474F4   o  ; was: sub_47508
                move.w  $4A(a5),d0
                cmpi.w  #6,d0
                bcs.s   loc_47514
                subq.w  #6,d0
loc_47514:                                              ; CODE XREF: Projectile_Epsilon1ChainSegment+8   j
                add.w   d0,d0
                lea     (dword_FF9400).w,a0
                move.w  (a0,d0.w),d1
                cmpi.w  #$80,d1
                bcs.s   locret_47530
                move.w  #$80,d0
                bsr.w   Effect_Epsilon1DefeatSpark1
                addq.w  #2,4(a5)
locret_47530:                                           ; CODE XREF: Projectile_Epsilon1ChainSegment+1A   j
                rts
; End of function Projectile_Epsilon1ChainSegment
; Ring projectile initialization
Projectile_Epsilon1RingInit:                            ; DATA XREF: ROM:000474F6   o  ; was: sub_47532
                move.w  $4A(a5),d0
                cmpi.w  #6,d0
                bcs.s   loc_4753E
                subq.w  #6,d0
loc_4753E:                                              ; CODE XREF: Projectile_Epsilon1RingInit+8   j
                add.w   d0,d0
                lea     (dword_FF9400).w,a0
                move.w  (a0,d0.w),d1
                cmpi.w  #$120,d1
                bcs.w   locret_475C2
                cmpi.w  #$180,d1
                bcc.w   locret_475C2
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
                bsr.w   Projectile_Epsilon1RingExpand
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_475C2
                jsr     (Sprite_InitType160).l
                move.l  #off_E95C0,8(a0)
                move.w  #$480,$E(a0)
                move.w  $10(a5),$10(a0)
                addi.w  #8,$10(a0)
                move.w  $14(a5),$14(a0)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_475C2
                jsr     (Sprite_InitType160).l
                move.l  #off_E95C0,8(a0)
                move.w  #$480,$E(a0)
                move.w  $10(a5),$10(a0)
                addi.w  #-8,$10(a0)
                move.w  $14(a5),$14(a0)
locret_475C2:                                           ; CODE XREF: Projectile_Epsilon1RingInit+1A   j
                                        ; Projectile_Epsilon1RingInit+22   j
                rts
; End of function Projectile_Epsilon1RingInit
; Ring expansion animation
Projectile_Epsilon1RingExpand:                          ; CODE XREF: Projectile_Epsilon1RingInit+30   p  ; was: sub_475C4
                                        ; Projectile_Epsilon1BurstInit+6   p
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF942C).w,a1
                move.w  (a1,d0.w),d0
                move.w  (dword_FFC690).w,d0
                add.w   $4C(a5),d0
                move.w  d0,$10(a5)
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF942C).w,a0
                move.w  #$1E0,d1
                sub.w   (a0,d0.w),d1
                subi.w  #$20,d1                         ; ' '
                move.w  d1,$14(a5)
                rts
; End of function Projectile_Epsilon1RingExpand
; Burst projectile initialization
Projectile_Epsilon1BurstInit:                           ; DATA XREF: ROM:000474F8   o  ; was: sub_475FA
                subq.w  #1,$48(a5)
                bne.s   locret_47644
                bsr.w   Projectile_Epsilon1RingExpand
                move.w  #9,$1C(a5)
                ori.w   #$8000,2(a5)
                move.b  #$40,$21(a5)                    ; '@'
                clr.w   $50(a5)
                movea.w $4E(a5),a0
                ori.w   #$8000,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                move.b  #$50,d0                         ; 'P'
                jsr     (Sound_PlaySFX).l
locret_47644:                                           ; CODE XREF: Projectile_Epsilon1BurstInit+4   j
                rts
; End of function Projectile_Epsilon1BurstInit
; Clears projectile state flags and velocity
Projectile_Epsilon1CleanupState:
                movea.w $4E(a5),a0                      ; was: sub_47646
                bset    #4,2(a0)
                andi.w  #$7FFF,2(a5)
                clr.w   4(a5)
; End of function Projectile_Epsilon1CleanupState
; Burst explosion effect
Projectile_Epsilon1BurstExplode:                        ; CODE XREF: Projectile_Epsilon1TrackingUpdate   p  ; was: sub_4765A
                moveq   #0,d0
; End of function Projectile_Epsilon1BurstExplode
; Defeat spark effect 1
Effect_Epsilon1DefeatSpark1:                            ; CODE XREF: Projectile_Epsilon1ChainSegment+20   p  ; was: sub_4765C
                                        ; Projectile_Epsilon1TrackingInit+C   p
                lea     (dword_FF944E).w,a1
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  d0,(a1,d1.w)
                rts
; End of function Effect_Epsilon1DefeatSpark1
; Tracking projectile initialization
Projectile_Epsilon1TrackingInit:                        ; DATA XREF: ROM:000474FA   o  ; was: sub_4766C
                cmpi.w  #$120,$48(a5)
                beq.s   loc_47682
                move.w  $48(a5),d0
                bsr.w   Effect_Epsilon1DefeatSpark1
                addi.w  #$10,$48(a5)
loc_47682:                                              ; CODE XREF: Projectile_Epsilon1TrackingInit+6   j
                cmpi.w  #$20,$50(a5)                    ; ' '
                beq.s   loc_4768E
                addq.w  #4,$50(a5)
loc_4768E:                                              ; CODE XREF: Projectile_Epsilon1TrackingInit+1C   j
                movea.w $4E(a5),a0
                ori.w   #$8000,2(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  $50(a5),d0
                sub.w   d0,$14(a0)
                cmpi.w  #$150,$14(a5)
                bcs.w   locret_476F2
                andi.w  #$7FFF,2(a5)
                clr.b   $21(a5)
                movea.w $4E(a5),a0
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.l  #off_E953C,8(a0)
                move.w  $1C(a5),d0
                neg.w   d0
                asr.w   #2,d0
                move.w  d0,$1C(a0)
                clr.l   $1C(a5)
                addq.w  #2,4(a5)
locret_476F2:                                           ; CODE XREF: Projectile_Epsilon1TrackingInit+46   j
                rts
; End of function Projectile_Epsilon1TrackingInit
; Tracking projectile AI
Projectile_Epsilon1TrackingUpdate:                      ; DATA XREF: ROM:000474FC   o  ; was: sub_476F4
                bsr.w   Projectile_Epsilon1BurstExplode
                clr.w   4(a5)
                rts
; End of function Projectile_Epsilon1TrackingUpdate
nullsub_93:                                             ; DATA XREF: ROM:000474FE   o
                rts
; End of function nullsub_93

; Defeat spark effect 2
Effect_Epsilon1DefeatSpark2:                            ; DATA XREF: ROM:00047500   o  ; was: sub_47700
                bsr.s   Effect_Epsilon1DefeatSpark3
                cmpi.w  #$140,$14(a5)
                blt.s   loc_47710
                addq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_47710:                                              ; CODE XREF: Effect_Epsilon1DefeatSpark2+8   j
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   locret_47752
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_47752
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$FFFE,$1C(a0)
                move.w  (dword_FFFF08).w,d0
                add.w   a5,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                move.l  #off_E95DC,8(a0)
locret_47752:                                           ; CODE XREF: Effect_Epsilon1DefeatSpark2+18   j
                                        ; Effect_Epsilon1DefeatSpark2+20   j
                rts
; End of function Effect_Epsilon1DefeatSpark2
; Defeat spark effect 3
Effect_Epsilon1DefeatSpark3:                            ; CODE XREF: Effect_Epsilon1DefeatSpark2   p  ; was: sub_47754
                addi.w  #$20,$50(a5)                    ; ' '
                move.w  $50(a5),d0
                bsr.w   Effect_Epsilon1DefeatSpark1
                move.w  (dword_FFC690).w,d0
                add.w   $4C(a5),d0
                move.w  d0,$10(a5)
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF942C).w,a0
                move.w  #$1E0,d1
                sub.w   (a0,d0.w),d1
                subi.w  #$20,d1                         ; ' '
                move.w  d1,$14(a5)
                cmpi.w  #$C,d0
                bcs.s   loc_47792
                subi.w  #$C,d0
loc_47792:                                              ; CODE XREF: Effect_Epsilon1DefeatSpark3+38   j
                lea     (dword_FF9466).w,a1
                addi.w  #-2,(a1,d0.w)
                rts
; End of function Effect_Epsilon1DefeatSpark3
; Defeat spark effect 4
Effect_Epsilon1DefeatSpark4:                            ; DATA XREF: ROM:00047502   o  ; was: sub_4779E
                jsr     (Projectile_ExplodeWithSound).l
                move.w  $4A(a5),d0
                add.w   d0,d0
                lea     (dword_FF9466).w,a1
                move.w  #$FF00,(a1,d0.w)
                addq.w  #2,4(a5)
                move.l  #off_E953C,8(a5)
                move.w  #$FFFF,$1C(a5)
                jmp     Projectile_InitType88FromCurrent
; End of function Effect_Epsilon1DefeatSpark4
nullsub_94:
                rts
; End of function nullsub_94

; Clears projectile entity and unsets bit #4
Projectile_Epsilon1Despawn:                             ; DATA XREF: ROM:00047504   o  ; was: sub_477CE
                clr.w   (a5)
                bclr    #4,2(a5)
                rts
; End of function Projectile_Epsilon1Despawn
; Checks if boss part is vulnerable
