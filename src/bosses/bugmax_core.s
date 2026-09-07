Boss_BugmaxMain:                                        ; DATA XREF: ROM:off_5DC   o  ; was: sub_4BEBC
                tst.w   4(a5)
                beq.w   Boss_BugmaxMainDispatch
                lea     (word_3E3C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$58(a5)
                move.w  $5E(a5),d0
                lea     off_4BEE8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxMain
; ---------------------------------------------------------------------------
off_4BEE8:      dc.w    Boss_BugmaxUpdateLegs-*         ; DATA XREF: Boss_BugmaxMain+24   o
                dc.w    Boss_BugmaxRotateParts1-*
                dc.w    Boss_BugmaxRotateParts2-*
                dc.w    Boss_BugmaxCalculatePerspective-*

; Updates all leg positions
Boss_BugmaxUpdateLegs:                                  ; DATA XREF: ROM:off_4BEE8   o  ; was: sub_4BEF0
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$128,d0
                move.w  d0,(dword_FFA90C).w
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
loc_4BF2E:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+58   j
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4BF2E
                move.w  $10(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
loc_4BF58:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+6E   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,loc_4BF58
                move.w  -$C(a0),d4
                move.w  -2(a0),d5
                move.w  d4,d0
                move.w  (dword_FFC694).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                cmpi.w  #$1C0,d2
                bcs.s   loc_4BF8A
                move.w  #$1C0,d2
                bra.s   loc_4BF94
; ---------------------------------------------------------------------------
loc_4BF8A:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+92   j
                cmpi.w  #$140,d2
                bhi.s   loc_4BF94
                move.w  #$140,d2
loc_4BF94:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+98   j
                                        ; Boss_BugmaxUpdateLegs+9E   j
                move.w  d2,(word_FFC6CC).w
                move.w  d5,d0
                move.w  (dword_FFC6F4).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                cmpi.w  #$C0,d2
                bcs.s   loc_4BFB8
                move.w  #$C0,d2
                bra.s   loc_4BFC2
; ---------------------------------------------------------------------------
loc_4BFB8:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+C0   j
                cmpi.w  #$40,d2                         ; '@'
                bhi.s   loc_4BFC2
                move.w  #$40,d2                         ; '@'
loc_4BFC2:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+C6   j
                                        ; Boss_BugmaxUpdateLegs+CC   j
                move.w  d2,(word_FFC72C).w
                move.w  d2,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4BFD0:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+EE   j
                move.w  #3,d6
loc_4BFD4:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+EA   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,loc_4BFD4
                dbf     d7,loc_4BFD0
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (word_FF9600).w,a1
                move.w  #$10,d6
                move.w  #3,d7
; Updates leg segment positions in loop
Boss_BugmaxLegPositionLoop:                             ; CODE XREF: Boss_BugmaxUpdateLegs+110   j  ; was: loc_4BFF2
                lea     $60(a0),a0
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                dbf     d7,Boss_BugmaxLegPositionLoop
                bra.w   loc_4C392
; End of function Boss_BugmaxUpdateLegs
; Rotation pattern 1 for parts
Boss_BugmaxRotateParts1:                                ; DATA XREF: ROM:0004BEEA   o  ; was: sub_4C008
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1F0,(dword_FFA90C).w
                movea.w #(word_FFC860-M68K_RAM),a1
                movea.w #(word_FFC800-M68K_RAM),a0
                move.w  #3,d7
; Rotates segments using polar coordinates
Boss_BugmaxRotateSegments:                              ; CODE XREF: Boss_BugmaxRotateParts1+4C   j  ; was: loc_4C02A
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                move.w  $50(a1),d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$100,d0
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     -$60(a0),a0
                dbf     d7,Boss_BugmaxRotateSegments
                movea.w a5,a0
                move.l  (dword_FFC6F0).w,d3
                move.l  (dword_FFC6F4).w,d4
                move.w  (word_FFC730).w,d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$100,d0
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                bra.w   loc_4C392
; End of function Boss_BugmaxRotateParts1
; Rotation pattern 2 for parts
Boss_BugmaxRotateParts2:                                ; DATA XREF: ROM:0004BEEC   o  ; was: sub_4C09A
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1F0,(dword_FFA90C).w
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
loc_4C0D2:                                              ; CODE XREF: Boss_BugmaxRotateParts2+5A   j
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                move.w  $50(a0),d2
                move.w  $4C(a0),d0
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4C0D2
                bra.w   loc_4C22C
; End of function Boss_BugmaxRotateParts2
; Calculates perspective distortion for Bugmax
Boss_BugmaxCalculatePerspective:                        ; DATA XREF: ROM:0004BEEE   o  ; was: sub_4C0FC
                move.w  #$190,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  #$60,d0                         ; '`'
                move.w  #$5F,d7                         ; '_'
                movea.w #(byte_FF9520-M68K_RAM),a0
loc_4C114:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+1C   j
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,loc_4C114
                tst.w   (dword_FF9400).w
                beq.w   loc_4C1E0
                tst.w   (dword_FF9400).w
                bmi.w   loc_4C184
                move.w  #$204,d0
                sub.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                moveq   #0,d2
                move.w  #$400,d2
                move.w  (dword_FF9400).w,d0
                divu.w  d0,d2
                swap    d2
                clr.w   d2
                lsr.l   #4,d2
                subi.l  #$10000,d2
                movea.w #(byte_FF9520-M68K_RAM),a0
                movea.w a0,a1
                move.w  $14(a5),d0
                subi.w  #8,d0
                subi.w  #$A0,d0
                andi.w  #$1FE,d0
                adda.w  d0,a0
                move.l  (dword_FFA90C).w,d1
                move.w  (dword_FF9400).w,d7
loc_4C170:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+82   j
                cmpa.w  a1,a0
                beq.w   loc_4C1E0
                sub.l   d2,d1
                move.l  d1,d4
                swap    d4
                move.w  d4,-(a0)
                dbf     d7,loc_4C170
                bra.s   loc_4C1E0
; ---------------------------------------------------------------------------
loc_4C184:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+2C   j
                move.w  #$22C,d0
                sub.w   $14(a5),d0
                move.w  d0,(dword_FFA90C).w
                moveq   #0,d2
                move.w  #$400,d2
                move.w  (dword_FF9400).w,d0
                neg.w   d0
                divu.w  d0,d2
                swap    d2
                clr.w   d2
                lsr.l   #4,d2
                subi.l  #$10000,d2
                movea.w #(byte_FF9520-M68K_RAM),a0
                movea.w a0,a1
                adda.w  #$C0,a1
                move.w  $14(a5),d0
                subi.w  #8,d0
                subi.w  #$A0,d0
                andi.w  #$1FE,d0
                adda.w  d0,a0
                move.l  (dword_FFA90C).w,d1
                move.w  (dword_FF9400).w,d7
                neg.w   d7
loc_4C1D0:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+E0   j
                cmpa.w  a1,a0
                beq.s   loc_4C1E0
                add.l   d2,d1
                move.l  d1,d4
                swap    d4
                move.w  d4,(a0)+
                dbf     d7,loc_4C1D0
loc_4C1E0:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+24   j
                                        ; Boss_BugmaxCalculatePerspective+76   j
                bsr.w   Boss_BugmaxPerspectiveHelper
                movea.w #(word_FFC680-M68K_RAM),a0
                cmpi.w  #$10,(a0)
                bne.w   loc_4C392
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
loc_4C20E:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+12C   j
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4C20E
loc_4C22C:                                              ; CODE XREF: Boss_BugmaxRotateParts2+5E   j
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
loc_4C242:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+14C   j
                move.l  (a0),d1
                move.l  d0,(a0)+
                move.l  d1,d0
                dbf     d7,loc_4C242
                move.l  -$18(a0),d5
                move.l  -4(a0),d6
                moveq   #0,d3
                moveq   #0,d4
                move.w  d5,d4
                swap    d5
                move.w  d5,d3
                sub.w   (dword_FFA900).w,d3
                swap    d3
                swap    d4
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  (dword_FF9414+2).w,d0
                addi.w  #$80,d0
                move.w  $50(a0),d2
                bsr.w   loc_4DB88
                swap    d0
                swap    d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  d2,(word_FFC6CC).w
                moveq   #0,d3
                moveq   #0,d4
                move.w  d6,d4
                swap    d6
                move.w  d6,d3
                sub.w   (dword_FFA900).w,d3
                swap    d3
                swap    d4
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  (dword_FF9414+2).w,d0
                subi.w  #$80,d0
                move.w  $50(a0),d2
                bsr.w   loc_4DB88
                swap    d0
                swap    d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (loc_355A).l
                move.w  d2,(word_FFC72C).w
                move.w  d2,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4C2D6:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+1E8   j
                move.w  #3,d6
loc_4C2DA:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+1E4   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,loc_4C2DA
                dbf     d7,loc_4C2D6
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (word_FF9600).w,a1
                move.w  #$10,d6
                move.w  #3,d7
loc_4C2F8:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+20A   j
                lea     $60(a0),a0
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                dbf     d7,loc_4C2F8
                move.w  (word_FFC6CC).w,d0
                add.w   d0,d0
                lea     (word_FF9680).w,a0
                move.w  #7,d7
loc_4C318:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+22A   j
                move.w  #7,d6
loc_4C31C:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+226   j
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,loc_4C31C
                dbf     d7,loc_4C318
                movea.w #(word_FFC8C0-M68K_RAM),a0
                lea     (word_FF9680).w,a1
                move.w  #$10,d6
                move.w  #7,d7
loc_4C33A:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+24C   j
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4C33A
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
                move.w  (dword_FF9410+2).w,d2
                movea.w #(word_FFC680-M68K_RAM),a1
loc_4C35C:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+28E   j
                tst.b   (dword_FF9418+2).w
                bne.s   loc_4C368
                move.w  $4C(a0),d0
                bra.s   loc_4C36C
; ---------------------------------------------------------------------------
loc_4C368:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+264   j
                move.w  (dword_FF9414).w,d0
loc_4C36C:                                              ; CODE XREF: Boss_BugmaxCalculatePerspective+26A   j
                add.w   $4E(a0),d0
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   loc_4DB88
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,loc_4C35C
                bsr.w   Boss_BugmaxToggleMouthSprite
loc_4C392:                                              ; CODE XREF: Boss_BugmaxUpdateLegs+114   j
                                        ; Boss_BugmaxRotateParts1+8E   j
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_BugmaxMainDispatch
                btst    #1,(byte_FF80EC).w
                bne.w   Boss_BugmaxMainDispatch
                tst.w   (word_FF8200).w
                bne.s   Boss_BugmaxMainDispatch
                move.b  #2,(byte_FF80EC).w
loc_4C3B0:
                bset    #0,$5A(a5)
                move.w  #$56,4(a5)                      ; 'V'
                move.w  #1,(dword_FF9428+2).w
                bset    #0,(byte_FFA272).w
                bra.w   *+4
; ---------------------------------------------------------------------------
; Main state dispatcher for Bugmax boss
Boss_BugmaxMainDispatch:                                ; CODE XREF: Boss_BugmaxMain+4   j  ; was: loc_4C3CC
                                        ; Boss_BugmaxCalculatePerspective+29C   j
                move.w  4(a5),d0
                lea     off_4C3D8(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxCalculatePerspective
; ---------------------------------------------------------------------------
off_4C3D8:      dc.w    Boss_BugmaxInit-*               ; DATA XREF: Boss_BugmaxCalculatePerspective+2D4   o
                dc.w    Boss_BugmaxShakeInit-*
                dc.w    Boss_BugmaxShaking-*
                dc.w    Boss_BugmaxVictoryCheck-*
                dc.w    Boss_BugmaxDefeatStart-*
                dc.w    Boss_BugmaxDefeatRise-*
                dc.w    Boss_BugmaxDefeatExplode-*
                dc.w    Boss_BugmaxSpinInit-*
                dc.w    Boss_BugmaxSpinning-*
                dc.w    Boss_BugmaxSpinReverse-*
                dc.w    Boss_BugmaxSpinSlowdown-*
                dc.w    Boss_BugmaxJumpPrepare-*
                dc.w    Boss_BugmaxJumpInit-*
                dc.w    Boss_BugmaxRotateMouthOpen-*
                dc.w    Boss_BugmaxRotateMouthClose-*
                dc.w    Boss_BugmaxLoadOpenMouthGfx-*
                dc.w    Boss_BugmaxLoadClosedMouthGfx-*
                dc.w    Boss_BugmaxMovementPhase1-*
                dc.w    Boss_BugmaxAttackPatternSelect-*
                dc.w    Boss_BugmaxEnterAttackStance1-*
                dc.w    Boss_BugmaxWaitAttackReady-*
                dc.w    Boss_BugmaxMoveAndCheckFlag-*
                dc.w    Boss_BugmaxProjectileAttack-*
                dc.w    Boss_BugmaxDistanceTrackLoop-*
                dc.w    Boss_BugmaxAttackCountdown-*
                dc.w    Boss_BugmaxPositionForHorizontal-*
                dc.w    Boss_BugmaxHorizontalMoveWait-*
                dc.w    Boss_BugmaxPrepareSpecialAttack-*
                dc.w    Boss_BugmaxAngleCalculateAttack-*
                dc.w    Boss_BugmaxSpecialAttackUpdate-*
                dc.w    Boss_BugmaxSpecialAttackWait-*
                dc.w    Boss_BugmaxSpecialAttackDecrement-*
                dc.w    Boss_BugmaxResetSpecialAttack-*
                dc.w    Boss_BugmaxSpecialAttackFinish-*
                dc.w    Boss_BugmaxEnterAttackStance2-*
                dc.w    Boss_BugmaxWaitCounter32-*
                dc.w    Boss_BugmaxSmartPositioning-*
                dc.w    Boss_BugmaxDistanceChasePlayer-*
                dc.w    Boss_BugmaxAttackDelay-*
                dc.w    Boss_BugmaxProjectileVerticalAttack-*
                dc.w    Boss_BugmaxHorizontalAttackLoop-*
                dc.w    Boss_BugmaxTimedStateTransition-*
                dc.w    Boss_BugmaxResetState-*
                dc.w    Boss_BugmaxLandCheck-*
                dc.w    Boss_BugmaxLandFlash-*
                dc.w    Boss_BugmaxScatterParts-*
                dc.w    Boss_BugmaxFallOffScreen-*
                dc.w    Boss_BugmaxWaitTimer-*
                dc.w    Boss_BugmaxRiseUp-*
                dc.w    Boss_BugmaxFallDown-*

; Initializes Bugmax with 7 parts
Boss_BugmaxInit:                                        ; DATA XREF: ROM:off_4C3D8   o  ; was: sub_4C43C
                tst.b   (word_FFF720).w
                bmi.w   locret_4C5BC
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #$300,d0
                moveq   #0,d1
                jsr     (Sprite_ClearAllExcept).l
                clr.w   $5E(a5)
                move.w  #$604,d0
                move.w  d0,$5C(a5)
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$C8,$14(a5)
                move.b  #$40,$20(a5)                    ; '@'
                move.l  #word_ECB94,8(a5)
                move.w  #$300,$E(a5)
                eori.w  #$800,$E(a5)
                move.w  #$CD80,2(a5)
                move.w  #$80,$26(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F010F010,$28(a5)
                move.b  #$D0,$21(a5)
                move.w  #4,$24(a5)
                move.w  #$40,$50(a5)                    ; '@'
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.l  #word_ECB88,8(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.l  #$F010F808,$28(a0)
                move.b  #$D0,$21(a0)
                move.b  #$80,$23(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$180,$4C(a0)
                move.w  #$50,$50(a0)                    ; 'P'
                move.w  #4,$24(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                moveq   #0,d6
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
loc_4C51E:                                              ; CODE XREF: Boss_BugmaxInit+144   j
                move.w  #$10,(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  #4,$24(a0)
                move.b  $20(a5),$20(a0)
                move.l  #$FE02FE02,$2C(a0)
                move.l  #$F808F010,$28(a0)
                move.b  #$D0,$21(a0)
                move.w  #$80,$26(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.w  #$80,$4C(a0)
                lea     stru_4C5BE(pc),a1
                nop
                move.w  (a1,d6.w),$50(a0)
                move.l  4(a1,d6.w),8(a0)
                addq.w  #8,d6
                lea     $60(a0),a0
                dbf     d7,loc_4C51E
                bsr.w   Boss_BugmaxLoadGfx
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$128,d0
                move.w  d0,(dword_FFA90C).w
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4C5AC:                                              ; CODE XREF: Boss_BugmaxInit+17C   j
                move.w  #3,d6
; Clears position buffer with loop
Boss_BugmaxClearBuffer:                                 ; CODE XREF: Boss_BugmaxInit+178   j  ; was: loc_4C5B0
                move.w  #$80,(a0)+
                dbf     d6,Boss_BugmaxClearBuffer
                dbf     d7,loc_4C5AC
locret_4C5BC:                                           ; CODE XREF: Boss_BugmaxInit+4   j
                rts
; End of function Boss_BugmaxInit
; ---------------------------------------------------------------------------
stru_4C5BE:     dc.w    $5C                             ; field_0
                                        ; DATA XREF: Boss_BugmaxInit+12C   o
                dc.w    $FF                             ; field_2
                dc.l    word_ECB9A                      ; field_4
                dc.w    $40                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA0                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA0                      ; field_4
                dc.w    $2C                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA6                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    $FF                             ; field_2
                dc.l    word_ECBA6                      ; field_4

; Loads Bugmax graphics
Boss_BugmaxLoadGfx:                                     ; CODE XREF: Boss_BugmaxInit+148   p  ; was: sub_4C5E6
                lea     word_4C5F2(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxLoadGfx
; ---------------------------------------------------------------------------
word_4C5F2:     dc.w    $6330, $2000, $104, $BEBF, $C2C3, $C6C7, $CACB, $CF
                                        ; DATA XREF: Boss_BugmaxLoadGfx   o

; Initializes shake animation
Boss_BugmaxShakeInit:                                   ; DATA XREF: ROM:0004C3DA   o  ; was: sub_4C602
                move.w  $5C(a5),$4A(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxShakeInit
; Shake animation state
Boss_BugmaxShaking:                                     ; DATA XREF: ROM:0004C3DC   o  ; was: sub_4C614
                subq.w  #1,$48(a5)
                beq.s   Boss_BugmaxShakeEnd
                move.w  $4A(a5),d0
                move.w  (word_FFA000).w,d7
                andi.w  #2,d7
                beq.s   loc_4C62C
                addi.w  #$60,d0                         ; '`'
loc_4C62C:                                              ; CODE XREF: Boss_BugmaxShaking+12   j
                move.w  d0,$5C(a5)
                rts
; ---------------------------------------------------------------------------
; Ends shaking and advances state
Boss_BugmaxShakeEnd:                                    ; CODE XREF: Boss_BugmaxShaking+4   j  ; was: loc_4C632
                move.w  $4A(a5),$5C(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxShaking
; Checks victory condition
Boss_BugmaxVictoryCheck:                                ; DATA XREF: ROM:0004C3DE   o  ; was: sub_4C644
                bsr.w   Boss_BugmaxClampLegPositions
                subq.w  #1,$48(a5)
                bne.s   locret_4C65C
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
locret_4C65C:                                           ; CODE XREF: Boss_BugmaxVictoryCheck+8   j
                rts
; End of function Boss_BugmaxVictoryCheck
; Starts defeat sequence
Boss_BugmaxDefeatStart:                                 ; DATA XREF: ROM:0004C3E0   o  ; was: sub_4C65E
                bsr.w   Boss_BugmaxClampLegPositions
                tst.w   (word_FF80C2).w
                bne.s   locret_4C680
                move.b  #$D0,$21(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (dword_FF9428+2).w
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
locret_4C680:                                           ; CODE XREF: Boss_BugmaxDefeatStart+8   j
                rts
; End of function Boss_BugmaxDefeatStart
; Boss rises during defeat
Boss_BugmaxDefeatRise:                                  ; DATA XREF: ROM:0004C3E2   o  ; was: sub_4C682
                bsr.w   Boss_BugmaxUpdateAllParts
                bsr.w   Boss_BugmaxClampLegPositions
                cmpi.w  #$6800,(word_FF8200).w
                bhi.s   locret_4C6A0
                addq.w  #2,4(a5)
                move.w  #3,d0
                bsr.w   Boss_BugmaxSpawnDebris
                bra.s   Boss_BugmaxDMADeathTiles
; ---------------------------------------------------------------------------
locret_4C6A0:                                           ; CODE XREF: Boss_BugmaxDefeatRise+E   j
                rts
; ---------------------------------------------------------------------------
; DMA transfers death animation tiles
Boss_BugmaxDMADeathTiles:                               ; CODE XREF: Boss_BugmaxDefeatRise+1C   j  ; was: loc_4C6A2
                lea     word_4C6AE(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxDefeatRise
; ---------------------------------------------------------------------------
word_4C6AE:     dc.w    $6330, $2000, $104, $BEBF, $C0C3, $C4C7, $C8CB, $CF
                                        ; DATA XREF: Boss_BugmaxDefeatRise:loc_4C6A2   o

; Spawns debris during defeat
Boss_BugmaxSpawnDebris:                                 ; CODE XREF: Boss_BugmaxDefeatRise+18   p  ; was: sub_4C6BE
                                        ; Boss_BugmaxDefeatExplode+20   p
                move.w  d0,d7
                subq.w  #1,d7
                clr.w   d6
; Spawns debris objects in loop
Boss_BugmaxSpawnDebrisLoop:                             ; CODE XREF: Boss_BugmaxSpawnDebris+38   j  ; was: loc_4C6C4
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4C6FA
                lea     word_4C70A(pc),a2
                nop
                move.w  (a2,d6.w),d0
                move.w  $E(a2,d6.w),d1
                move.w  $1C(a2,d6.w),d2
                movea.w word_4C6FC(pc,d6.w),a1
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                jsr     (Projectile_InitDebrisObject).l
                addq.w  #2,d6
                dbf     d7,Boss_BugmaxSpawnDebrisLoop
locret_4C6FA:                                           ; CODE XREF: Boss_BugmaxSpawnDebris+C   j
                rts
; End of function Boss_BugmaxSpawnDebris
; ---------------------------------------------------------------------------
word_4C6FC:     dc.w    $C620, $C6E0, $C740, $C7A0, $C680, $C800, $C860
                                        ; DATA XREF: Boss_BugmaxSpawnDebris+20   r
word_4C70A:     dc.w    $40, $40, $40, $40, $28, $28, $18
                                        ; DATA XREF: Boss_BugmaxSpawnDebris+E   o
                dc.w    $20, $20, $20, $10, 8, 8, 4
                dc.w    $10, $10, $10, $10, 8, 8, 8

; Explosion during defeat
Boss_BugmaxDefeatExplode:                               ; DATA XREF: ROM:0004C3E4   o  ; was: sub_4C734
                bsr.w   Boss_BugmaxUpdateAllParts
                bsr.w   Boss_BugmaxClampLegPositions
                cmpi.w  #$6000,(word_FF8200).w
                bhi.s   locret_4C75A
                clr.l   $18(a5)
                addq.w  #2,$5E(a5)
                addq.w  #2,4(a5)
                move.w  #7,d0
                bsr.w   Boss_BugmaxSpawnDebris
                bra.s   Boss_BugmaxDMAExplodeTiles
; ---------------------------------------------------------------------------
locret_4C75A:                                           ; CODE XREF: Boss_BugmaxDefeatExplode+E   j
                rts
; ---------------------------------------------------------------------------
; DMA transfers explosion tiles
Boss_BugmaxDMAExplodeTiles:                             ; CODE XREF: Boss_BugmaxDefeatExplode+24   j  ; was: loc_4C75C
                lea     word_4C768(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxDefeatExplode
; ---------------------------------------------------------------------------
word_4C768:     dc.w    $6330, $2000, $104, $BCBD, $C1, $C5, $C9, $CD
                                        ; DATA XREF: Boss_BugmaxDefeatExplode:loc_4C75C   o

; Initializes spin attack
Boss_BugmaxSpinInit:                                    ; DATA XREF: ROM:0004C3E6   o  ; was: sub_4C778
                move.w  (word_FFC72C).w,$4C(a5)
                move.w  #$118,$4A(a5)
                move.w  #$80,(word_FFC8AC).w
                bsr.w   Boss_BugmaxSyncLegRotation
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxSpinInit
; Spinning attack state
Boss_BugmaxSpinning:                                    ; DATA XREF: ROM:0004C3E8   o  ; was: sub_4C794
                movea.w #(word_FFC680-M68K_RAM),a0
                bsr.w   Boss_BugmaxUpdateLegSprite
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   $4A(a5),d0
                move.w  d0,(dword_FFC874).w
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   locret_4C7DA
                addq.w  #1,$48(a5)
                cmpi.w  #8,$48(a5)
                bcc.s   loc_4C7D0
                move.w  $48(a5),d0
                neg.w   d0
                bsr.w   Boss_BugmaxSetLegOffsets
                rts
; ---------------------------------------------------------------------------
loc_4C7D0:                                              ; CODE XREF: Boss_BugmaxSpinning+2E   j
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_4C7DA:                                           ; CODE XREF: Boss_BugmaxSpinning+22   j
                rts
; End of function Boss_BugmaxSpinning
; Sets leg rotation offsets
Boss_BugmaxSetLegOffsets:                               ; CODE XREF: Boss_BugmaxSpinning+36   p  ; was: sub_4C7DC
                                        ; Boss_BugmaxSpinReverse+2A   p
                move.w  #6,d7
                moveq   #0,d6
                lea     word_4C7F8(pc),a1
                nop
; Sets leg angle offsets in loop
Boss_BugmaxSetLegOffsetsLoop:                           ; CODE XREF: Boss_BugmaxSetLegOffsets+16   j  ; was: loc_4C7E8
                movea.w (a1)+,a0
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                dbf     d7,Boss_BugmaxSetLegOffsetsLoop
                rts
; End of function Boss_BugmaxSetLegOffsets
; ---------------------------------------------------------------------------
word_4C7F8:     dc.w    $C860, $C800, $C7A0, $C740, $C6E0, $C620, $C680
                                        ; DATA XREF: Boss_BugmaxSetLegOffsets+6   o
                                        ; sub_4C806   o

; Synchronizes leg rotations
Boss_BugmaxSyncLegRotation:                             ; CODE XREF: Boss_BugmaxSpinInit+12   p  ; was: sub_4C806
                lea     word_4C7F8(pc),a1
                movea.w (a1)+,a0
                move.w  $4C(a0),d0
                move.w  #5,d7
loc_4C814:                                              ; CODE XREF: Boss_BugmaxSyncLegRotation+14   j
                movea.w (a1)+,a0
                move.w  d0,$4C(a0)
                dbf     d7,loc_4C814
                subi.w  #$100,(word_FFC6CC).w
                andi.w  #$1FF,(word_FFC6CC).w
                rts
; End of function Boss_BugmaxSyncLegRotation
; Updates leg sprite based on angle
Boss_BugmaxUpdateLegSprite:                             ; CODE XREF: Boss_BugmaxSpinning+4   p  ; was: sub_4C82C
                                        ; Boss_BugmaxSpinReverse+4   p
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                andi.w  #$F7FF,$E(a0)
                andi.w  #$EFFF,$E(a0)
                cmpi.w  #$160,d0
                bcs.s   loc_4C874
                cmpi.w  #$170,d0
                bhi.s   loc_4C864
                ori.w   #$800,$E(a0)
                move.l  #word_ECB7C,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_4C864:                                              ; CODE XREF: Boss_BugmaxUpdateLegSprite+26   j
                ori.w   #$800,$E(a0)
                move.l  #word_ECB88,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_4C874:                                              ; CODE XREF: Boss_BugmaxUpdateLegSprite+20   j
                ori.w   #$800,$E(a0)
                move.l  #word_ECB6A,8(a0)
                rts
; End of function Boss_BugmaxUpdateLegSprite
; Reverse spin attack
Boss_BugmaxSpinReverse:                                 ; DATA XREF: ROM:0004C3EA   o  ; was: sub_4C884
                movea.w #(word_FFC680-M68K_RAM),a0
                bsr.w   Boss_BugmaxUpdateLegSprite
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   $4A(a5),d0
                move.w  d0,(dword_FFC874).w
                move.b  (dword_FFFF08).w,d0
                andi.w  #1,d0
                subq.w  #1,d0
                addi.w  #8,d0
                neg.w   d0
                bsr.w   Boss_BugmaxSetLegOffsets
                subq.w  #1,$48(a5)
                bne.s   locret_4C8C2
                move.w  #$FFF8,$48(a5)
                addq.w  #2,4(a5)
locret_4C8C2:                                           ; CODE XREF: Boss_BugmaxSpinReverse+32   j
                rts
; End of function Boss_BugmaxSpinReverse
; Slows down spin attack
Boss_BugmaxSpinSlowdown:                                ; DATA XREF: ROM:0004C3EC   o  ; was: sub_4C8C4
                move.w  $48(a5),d0
                bsr.w   Boss_BugmaxSetLegOffsets
                subq.w  #1,$48(a5)
                cmpi.w  #$FFEC,$48(a5)
                bne.s   locret_4C8DC
                addq.w  #2,4(a5)
locret_4C8DC:                                           ; CODE XREF: Boss_BugmaxSpinSlowdown+12   j
                rts
; End of function Boss_BugmaxSpinSlowdown
; Prepares jump attack
Boss_BugmaxJumpPrepare:                                 ; DATA XREF: ROM:0004C3EE   o  ; was: sub_4C8DE
                move.w  $48(a5),d0
                bsr.w   Boss_BugmaxSetLegOffsets
                addq.w  #1,$48(a5)
                bne.s   locret_4C90A
                move.l  #$FFFA0000,(dword_FFC87C).w
                move.l  #$FFFD0000,(dword_FFC878).w
                addq.w  #2,4(a5)
                move.b  #$E4,d0
                jsr     (Sound_PlaySFX).l
locret_4C90A:                                           ; CODE XREF: Boss_BugmaxJumpPrepare+C   j
                rts
; End of function Boss_BugmaxJumpPrepare
; Adjusts angle based on horizontal scroll
Boss_BugmaxAdjustAngleByScroll:                         ; CODE XREF: Boss_BugmaxRotateMouthClose+8   p  ; was: sub_4C90C
                move.w  $4A(a5),d0
                move.w  (word_FFA000).w,d7
                btst    #0,d7
                bne.s   loc_4C920
                move.w  d0,$5C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4C920:                                              ; CODE XREF: Boss_BugmaxAdjustAngleByScroll+C   j
                cmpi.w  #$410,(dword_FFA900).w
                bcc.s   loc_4C92E
                subi.w  #$80,d0
                rts
; ---------------------------------------------------------------------------
loc_4C92E:                                              ; CODE XREF: Boss_BugmaxAdjustAngleByScroll+1A   j
                addi.w  #$80,d0
                move.w  d0,$5C(a5)
                rts
; End of function Boss_BugmaxAdjustAngleByScroll
; DMA transfer wrapper for Bugmax graphics
