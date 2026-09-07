Gfx_BugmaxDMATransferWrapper:                           ; CODE XREF: Boss_BugmaxRotateMouthClose+26   p  ; was: sub_4C938
                lea     word_4C944(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Gfx_BugmaxDMATransferWrapper
; ---------------------------------------------------------------------------
word_4C944:     dc.w    $6330, $2000, $104, 0, 0, 0, 0, 0
                                        ; DATA XREF: Gfx_BugmaxDMATransferWrapper   o

; Initializes jump attack phase
Boss_BugmaxJumpInit:                                    ; DATA XREF: ROM:0004C3F0   o  ; was: sub_4C954
                addq.w  #2,4(a5)
                move.l  (dword_FFC878).w,d0
                move.l  d0,$18(a5)
                move.l  (dword_FFC87C).w,d0
                asr.l   #1,d0
                move.l  d0,$1C(a5)
                move.w  #$100,(dword_FF9414+2).w
                move.b  #$40,$20(a5)                    ; '@'
                move.l  #word_ECB52,8(a5)
                move.w  #$300,$E(a5)
                move.w  #$CD80,2(a5)
                move.w  #$80,$26(a5)
                move.l  #$F808F808,$2C(a5)
                move.l  #$F808F808,$28(a5)
                move.w  #$14,$24(a5)
                move.w  #0,$4C(a5)
                move.w  #0,$4E(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  #word_ECB28,8(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  #$80,$26(a0)
                move.l  #$F808F808,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.b  #$80,$23(a0)
                move.w  #$1C,$24(a0)
                move.b  $20(a5),$20(a0)
                subq.b  #4,$20(a0)
                move.w  #$180,$4C(a0)
                move.w  #0,$4E(a0)
                move.w  #$40,$50(a0)                    ; '@'
                moveq   #0,d6
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
loc_4CA12:                                              ; CODE XREF: Boss_BugmaxJumpInit+110   j
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.w  #$80,$26(a0)
                move.l  #$F808F808,$2C(a0)
                move.l  #$F808F808,$28(a0)
                move.w  #2,$24(a0)
                move.b  $20(a5),$20(a0)
                move.w  #$80,$4C(a0)
                lea     stru_4CB06(pc),a1
                nop
                move.w  (a1,d6.w),$50(a0)
                move.w  2(a1,d6.w),$4E(a0)
                move.l  4(a1,d6.w),8(a0)
                addq.w  #8,d6
                lea     $60(a0),a0
                dbf     d7,loc_4CA12
                moveq   #0,d6
                lea     off_4CB2E(pc),a1
                nop
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
loc_4CA78:                                              ; CODE XREF: Boss_BugmaxJumpInit+146   j
                move.w  #$10,(a0)
                move.w  $E(a5),$E(a0)
                move.w  2(a5),2(a0)
                move.b  $20(a5),$20(a0)
                move.l  (a1,d6.w),8(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4CA78
                move.l  #$FF01FF01,-$34(a0)
                move.w  #$10,-$3A(a0)
                move.b  #$40,-$3F(a0)                   ; '@'
                move.w  #$20,(dword_FF9410).w           ; ' '
                addq.w  #2,$5E(a5)
                move.w  $5C(a5),$4A(a5)
                move.w  #$180,(word_FFC6CC).w
                move.w  #$80,(word_FFC72C).w
                move.w  #$A0,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
loc_4CADA:                                              ; CODE XREF: Boss_BugmaxJumpInit+190   j
                move.w  #3,d6
loc_4CADE:                                              ; CODE XREF: Boss_BugmaxJumpInit+18C   j
                move.w  d0,(a0)+
                dbf     d6,loc_4CADE
                dbf     d7,loc_4CADA
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
loc_4CAFE:                                              ; CODE XREF: Boss_BugmaxJumpInit+1AC   j
                move.l  d0,(a0)+
                dbf     d7,loc_4CAFE
                rts
; End of function Boss_BugmaxJumpInit
; ---------------------------------------------------------------------------
stru_4CB06:     dc.w    $5C                             ; field_0
                                        ; DATA XREF: Boss_BugmaxJumpInit+F2   o
                dc.w    0                               ; field_2
                dc.l    word_ECB58                      ; field_4
                dc.w    $40                             ; field_0
                dc.w    $FFDC                           ; field_2
                dc.l    word_ECB5E                      ; field_4
                dc.w    $30                             ; field_0
                dc.w    $FFD4                           ; field_2
                dc.l    word_ECB5E                      ; field_4
                dc.w    $2C                             ; field_0
                dc.w    $FFC8                           ; field_2
                dc.l    word_ECB64                      ; field_4
                dc.w    $28                             ; field_0
                dc.w    $FFB8                           ; field_2
                dc.l    word_ECB64                      ; field_4
off_4CB2E:      dc.l    word_ECB46                      ; DATA XREF: Boss_BugmaxJumpInit+116   o
                dc.l    word_ECB46
                dc.l    word_ECB46
                dc.l    word_ECB4C
                dc.l    word_ECB4C
                dc.l    word_ECB4C
                dc.l    word_ECB4C
                dc.l    word_ECB4C

; Rotates mouth opening animation
Boss_BugmaxRotateMouthOpen:                             ; DATA XREF: ROM:0004C3F2   o  ; was: sub_4CB4E
                addi.l  #$1800,$1C(a5)
                addi.w  #$10,(dword_FF9414+2).w
                andi.w  #$1F0,(dword_FF9414+2).w
                cmpi.w  #$140,(dword_FF9414+2).w
                bne.w   locret_4CB70
                addq.w  #2,4(a5)
locret_4CB70:                                           ; CODE XREF: Boss_BugmaxRotateMouthOpen+1A   j
                rts
; End of function Boss_BugmaxRotateMouthOpen
; Rotates mouth closing and inits battle
Boss_BugmaxRotateMouthClose:                            ; DATA XREF: ROM:0004C3F4   o  ; was: sub_4CB72
                addi.l  #$1800,$1C(a5)
                bsr.w   Boss_BugmaxAdjustAngleByScroll
                subi.w  #8,(dword_FF9414+2).w
                andi.w  #$1F8,(dword_FF9414+2).w
                cmpi.w  #$180,(dword_FF9414+2).w
                bne.w   locret_4CBFC
                addq.w  #2,4(a5)
                bsr.w   Gfx_BugmaxDMATransferWrapper
                move.b  #$D0,$21(a5)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.b  #$D0,$21(a0)
                move.w  #$60,$50(a0)                    ; '`'
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #2,d7
loc_4CBBA:                                              ; CODE XREF: Boss_BugmaxRotateMouthClose+52   j
                move.b  #$D0,$21(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4CBBA
                move.w  #$10,$48(a5)
                move.w  #$10,(word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.b  #2,(byte_FFA95B).w
                move.w  #$E,(word_FF8090).w
                move.w  #$140,(dword_FF940C).w
                move.w  #$140,(dword_FF940C+2).w
                move.l  #$C0000,(dword_FF9408).w
                addq.w  #2,$5E(a5)
locret_4CBFC:                                           ; CODE XREF: Boss_BugmaxRotateMouthClose+1E   j
                rts
; End of function Boss_BugmaxRotateMouthClose
; Loads compressed graphics for open mouth
Boss_BugmaxLoadOpenMouthGfx:                            ; DATA XREF: ROM:0004C3F6   o  ; was: sub_4CBFE
                subq.w  #1,$48(a5)
                bne.w   locret_4CC28
                addq.w  #2,4(a5)
                lea     word_4CC16(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
word_4CC16:     dc.w    $6330, $2000, $302, $B3B2, $B1B0, $B7B6, $B5B4, $BBBA, $B900
                                        ; DATA XREF: Boss_BugmaxLoadOpenMouthGfx+C   o
; ---------------------------------------------------------------------------
locret_4CC28:                                           ; CODE XREF: Boss_BugmaxLoadOpenMouthGfx+4   j
                rts
; End of function Boss_BugmaxLoadOpenMouthGfx
; Loads compressed graphics for closed mouth
Boss_BugmaxLoadClosedMouthGfx:                          ; DATA XREF: ROM:0004C3F8   o  ; was: sub_4CC2A
                tst.b   (word_FFF720).w
                bmi.s   locret_4CC52
                addq.w  #2,4(a5)
                lea     word_4CC40(pc),a0
                nop
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
word_4CC40:     dc.w    $6930, $2000, $302, $DBDA, $D900, $D7D6, $D5D4, $D3D2, $D1D0
                                        ; DATA XREF: Boss_BugmaxLoadClosedMouthGfx+A   o
; ---------------------------------------------------------------------------
locret_4CC52:                                           ; CODE XREF: Boss_BugmaxLoadClosedMouthGfx+4   j
                rts
; End of function Boss_BugmaxLoadClosedMouthGfx
; Updates movement and waits for angle counter
Boss_BugmaxMovementPhase1:                              ; DATA XREF: ROM:0004C3FA   o  ; was: sub_4CC54
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                cmpi.w  #$18,(dword_FF9410).w
                bne.s   locret_4CC70
                clr.w   (dword_FF9424+2).w
                addq.w  #2,4(a5)
locret_4CC70:                                           ; CODE XREF: Boss_BugmaxMovementPhase1+12   j
                rts
; End of function Boss_BugmaxMovementPhase1
; Selects attack pattern based on player
Boss_BugmaxAttackPatternSelect:                         ; DATA XREF: ROM:0004C3FC   o  ; was: sub_4CC72
                clr.b   (dword_FF9418+1).w
                clr.w   (dword_FF9424).w
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  (word_FF8248).w,d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$530,d0
                bcc.w   loc_4CD3A
loc_4CC8E:                                              ; CODE XREF: Boss_BugmaxAttackPhaseHandler+48   j
                clr.w   $54(a5)
                move.w  $56(a5),d0
                move.w  word_4CCBC(pc,d0.w),(dword_FF9424+2).w
                bsr.s   Boss_BugmaxAttackPatternDispatch
                addq.w  #2,$56(a5)
                andi.w  #$1E,$56(a5)
                rts
; End of function Boss_BugmaxAttackPatternSelect
; Dispatcher for attack pattern execution
Boss_BugmaxAttackPatternDispatch:                       ; CODE XREF: Boss_BugmaxAttackPatternSelect+2A   p  ; was: sub_4CCAA
                move.w  (dword_FF9424+2).w,d0
                lea     off_4CCB6(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxAttackPatternDispatch
; ---------------------------------------------------------------------------
off_4CCB6:      dc.w    Boss_BugmaxAttackPattern2-*     ; DATA XREF: Boss_BugmaxAttackPatternDispatch+4   o
                dc.w    Boss_BugmaxInitAttackState-*
                dc.w    Boss_BugmaxAttackPhaseHandler-*
word_4CCBC:     dc.w    4, 0, 4, 2, 4, 0, 4, 2, 4, 2, 4, 0, 4, 2, 4, 0
                                        ; DATA XREF: Boss_BugmaxAttackPatternSelect+24   r

; Initializes attack state parameters
Boss_BugmaxInitAttackState:                             ; CODE XREF: Boss_BugmaxAttackPhaseHandler+16   j  ; was: sub_4CCDC
                                        ; Boss_BugmaxAttackPattern2+12   j
                                        ; DATA XREF:
                move.w  #$80,(dword_FF940C).w
                move.w  #$80,(dword_FF940C+2).w
                move.w  #$B0,(dword_FF9420).w
                move.w  #$20,(dword_FF9420+2).w         ; ' '
                move.w  #$44,4(a5)                      ; 'D'
                rts
; End of function Boss_BugmaxInitAttackState
; Handles attack phase logic
Boss_BugmaxAttackPhaseHandler:                          ; DATA XREF: ROM:0004CCBA   o  ; was: sub_4CCFC
                tst.b   (dword_FF9418+3).w
                beq.s   loc_4CD1A
                bne.w   locret_4CD9A
                move.w  (word_FF824A).w,d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$530,d0
                bcs.w   Boss_BugmaxInitAttackState
                bra.w   loc_4CD3A
; ---------------------------------------------------------------------------
loc_4CD1A:                                              ; CODE XREF: Boss_BugmaxAttackPhaseHandler+4   j
                move.w  #$80,(dword_FF940C).w
                move.w  #$140,(dword_FF940C+2).w
                move.w  #$C0,(dword_FF9420).w
                move.w  #$20,(dword_FF9420+2).w         ; ' '
                move.w  #$26,4(a5)                      ; '&'
                rts
; ---------------------------------------------------------------------------
loc_4CD3A:                                              ; CODE XREF: Boss_BugmaxAttackPatternSelect+18   j
                                        ; Boss_BugmaxAttackPhaseHandler+1A   j
                addq.w  #1,$54(a5)
                andi.w  #3,$54(a5)
                beq.w   loc_4CC8E
                move.w  #$140,(dword_FF940C).w
                move.w  #$100,(dword_FF940C+2).w
                move.w  #$E0,(dword_FF9420).w
                move.w  #$20,(dword_FF9420+2).w         ; ' '
                move.w  #$32,4(a5)                      ; '2'
                rts
; End of function Boss_BugmaxAttackPhaseHandler
; Attack pattern with specific coordinates
Boss_BugmaxAttackPattern2:                              ; DATA XREF: ROM:off_4CCB6   o  ; was: sub_4CD68
                tst.b   (dword_FF9418+3).w
                beq.s   loc_4CD82
                move.w  (word_FF824A).w,d0
                add.w   (dword_FFA900).w,d0
                cmpi.w  #$530,d0
                bcs.w   Boss_BugmaxInitAttackState
                bra.w   loc_4CD3A
; ---------------------------------------------------------------------------
loc_4CD82:                                              ; CODE XREF: Boss_BugmaxAttackPattern2+4   j
                move.w  #$140,(dword_FF940C).w
                move.w  #$140,(dword_FF940C+2).w
                move.w  #$C0,(dword_FF9420).w
                move.w  #$80,(dword_FF9420+2).w
locret_4CD9A:                                           ; CODE XREF: Boss_BugmaxAttackPhaseHandler+6   j
                rts
; End of function Boss_BugmaxAttackPattern2
; Sets up boss attack stance
Boss_BugmaxEnterAttackStance1:                          ; DATA XREF: ROM:0004C3FE   o  ; was: sub_4CD9C
                bsr.w   Boss_BugmaxUpdateMovement
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxEnterAttackStance1
; Waits for attack preparation counter
Boss_BugmaxWaitAttackReady:                             ; DATA XREF: ROM:0004C400   o  ; was: sub_4CDAC
                bsr.w   Boss_BugmaxUpdateMovement
                addq.w  #1,(dword_FF9408).w
                cmpi.w  #$18,(dword_FF9408).w
                bne.s   locret_4CDE0
                clr.b   (dword_FF9418+1).w
                clr.w   (dword_FF9424).w
                bset    #0,(dword_FF9418+1).w
                bclr    #0,(dword_FF941C).w
                move.w  #$10,$4A(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
locret_4CDE0:                                           ; CODE XREF: Boss_BugmaxWaitAttackReady+E   j
                rts
; End of function Boss_BugmaxWaitAttackReady
; Executes movement with horizontal AI
Boss_BugmaxMoveAndCheckFlag:                            ; DATA XREF: ROM:0004C402   o  ; was: sub_4CDE2
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                subq.w  #1,$48(a5)
                beq.s   loc_4CDF8
                bclr    #0,(dword_FF941C).w
                beq.s   locret_4CDFC
loc_4CDF8:                                              ; CODE XREF: Boss_BugmaxMoveAndCheckFlag+C   j
                addq.w  #2,4(a5)
locret_4CDFC:                                           ; CODE XREF: Boss_BugmaxMoveAndCheckFlag+14   j
                rts
; End of function Boss_BugmaxMoveAndCheckFlag
; Handles projectile attack with trajectory
Boss_BugmaxProjectileAttack:                            ; DATA XREF: ROM:0004C404   o  ; was: sub_4CDFE
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4CE1C
                bsr.w   Projectile_InitBugmaxSpread
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_4CE1C:                                           ; CODE XREF: Boss_BugmaxProjectileAttack+E   j
                rts
; End of function Boss_BugmaxProjectileAttack
; Tracks player distance and loops attack
Boss_BugmaxDistanceTrackLoop:                           ; DATA XREF: ROM:0004C406   o  ; was: sub_4CE1E
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                tst.b   (dword_FF9418+3).w
                bne.s   loc_4CE44
                jsr     (Physics_CalculateDistanceTo).l
                subq.w  #1,$48(a5)
                bne.s   locret_4CE42
                subq.w  #1,$4A(a5)
                beq.s   loc_4CE44
                subq.w  #2,4(a5)
locret_4CE42:                                           ; CODE XREF: Boss_BugmaxDistanceTrackLoop+18   j
                rts
; ---------------------------------------------------------------------------
loc_4CE44:                                              ; CODE XREF: Boss_BugmaxDistanceTrackLoop+C   j
                                        ; Boss_BugmaxDistanceTrackLoop+1E   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxDistanceTrackLoop
; Countdown timer for state transition
Boss_BugmaxAttackCountdown:                             ; DATA XREF: ROM:0004C408   o  ; was: sub_4CE4A
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9408).w
                cmpi.w  #$C,(dword_FF9408).w
                bne.s   locret_4CE60
                move.w  #$24,4(a5)                      ; '$'
locret_4CE60:                                           ; CODE XREF: Boss_BugmaxAttackCountdown+E   j
                rts
; End of function Boss_BugmaxAttackCountdown
; Positions boss for horizontal movement
Boss_BugmaxPositionForHorizontal:                       ; DATA XREF: ROM:0004C40A   o  ; was: sub_4CE62
                bsr.w   Boss_BugmaxUpdateMovement
                clr.b   (dword_FF9418+1).w
                bclr    #0,(dword_FF941C).w
                bset    #0,(dword_FF9418+1).w
                move.w  (dword_FFA900).w,d0
                add.w   (word_FF8248).w,d0
                subi.w  #$80,d0
                move.w  d0,(dword_FF9424).w
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxPositionForHorizontal
; Executes horizontal AI with timeout
Boss_BugmaxHorizontalMoveWait:                          ; DATA XREF: ROM:0004C40C   o  ; was: sub_4CE92
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                bclr    #0,(dword_FF941C).w
                bne.s   loc_4CEA8
                subq.w  #1,$48(a5)
                bne.s   locret_4CEB6
loc_4CEA8:                                              ; CODE XREF: Boss_BugmaxHorizontalMoveWait+E   j
                clr.b   (dword_FF9418+1).w
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
locret_4CEB6:                                           ; CODE XREF: Boss_BugmaxHorizontalMoveWait+14   j
                rts
; End of function Boss_BugmaxHorizontalMoveWait
; Prepares special attack with timer
Boss_BugmaxPrepareSpecialAttack:                        ; DATA XREF: ROM:0004C40E   o  ; was: sub_4CEB8
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  #$60,$48(a5)                    ; '`'
                move.b  #1,(dword_FF9418+2).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxPrepareSpecialAttack
; Calculates angle to player for attack
Boss_BugmaxAngleCalculateAttack:                        ; DATA XREF: ROM:0004C410   o  ; was: sub_4CECE
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  $48(a5),d0
                move.w  word_4CF20(pc,d0.w),(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                subq.w  #2,$48(a5)
                bpl.s   locret_4CF1E
                jsr     (Math_CalculateAngleToPlayer).l
                cmpi.w  #$100,d2
                bcc.s   loc_4CEFE
                cmpi.w  #$40,d2                         ; '@'
                bcs.s   loc_4CF08
                move.w  #$40,d2                         ; '@'
                bra.s   loc_4CF08
; ---------------------------------------------------------------------------
loc_4CEFE:                                              ; CODE XREF: Boss_BugmaxAngleCalculateAttack+22   j
                cmpi.w  #$1C0,d2
                bhi.s   loc_4CF08
                move.w  #$1C0,d2
loc_4CF08:                                              ; CODE XREF: Boss_BugmaxAngleCalculateAttack+28   j
                                        ; Boss_BugmaxAngleCalculateAttack+2E   j
                move.w  d2,(dword_FF9414).w
                bsr.w   Boss_BugmaxEnableHitbox
                addq.w  #2,4(a5)
                move.b  #$E2,d0
                jsr     (Sound_PlaySFX).l
locret_4CF1E:                                           ; CODE XREF: Boss_BugmaxAngleCalculateAttack+16   j
                rts
; End of function Boss_BugmaxAngleCalculateAttack
; ---------------------------------------------------------------------------
word_4CF20:     dc.w    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                                        ; DATA XREF: Boss_BugmaxAngleCalculateAttack+8   r
                dc.w    $20, $1F, $1E, $1D, $1C, $1B, $1A, $19
                dc.w    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                dc.w    $20, $1F, $1E, $1D, $1C, $1B, $1A, $19
                dc.w    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
                dc.w    $20, $1F, $1E, $1D, $1C, $1B, $1A, $19

; Updates special attack animation
Boss_BugmaxSpecialAttackUpdate:                         ; DATA XREF: ROM:0004C412   o  ; was: sub_4CF80
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxFlashEffect
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                tst.w   (dword_FF9410).w
                bne.s   locret_4CFA0
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4CFA0:                                           ; CODE XREF: Boss_BugmaxSpecialAttackUpdate+14   j
                rts
; End of function Boss_BugmaxSpecialAttackUpdate
; Waits 8 frames during special attack
Boss_BugmaxSpecialAttackWait:                           ; DATA XREF: ROM:0004C414   o  ; was: sub_4CFA2
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxFlashEffect
                subq.w  #1,$48(a5)
                bne.s   locret_4CFB4
                addq.w  #2,4(a5)
locret_4CFB4:                                           ; CODE XREF: Boss_BugmaxSpecialAttackWait+C   j
                rts
; End of function Boss_BugmaxSpecialAttackWait
; Decrements attack counter with animation
Boss_BugmaxSpecialAttackDecrement:                      ; DATA XREF: ROM:0004C416   o  ; was: sub_4CFB6
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxDisableFlashEffect
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                cmpi.w  #$FFE0,(dword_FF9410).w
                bne.s   locret_4CFD2
                addq.w  #2,4(a5)
locret_4CFD2:                                           ; CODE XREF: Boss_BugmaxSpecialAttackDecrement+16   j
                rts
; End of function Boss_BugmaxSpecialAttackDecrement
; Resets special attack counter
Boss_BugmaxResetSpecialAttack:                          ; DATA XREF: ROM:0004C418   o  ; was: sub_4CFD4
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  #$20,(dword_FF9410).w           ; ' '
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxResetSpecialAttack
; Finishes special attack and clears flags
Boss_BugmaxSpecialAttackFinish:                         ; DATA XREF: ROM:0004C41A   o  ; was: sub_4CFE4
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9410).w
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                cmpi.w  #$18,(dword_FF9410).w
                bne.s   locret_4D006
                clr.b   (dword_FF9418+2).w
                clr.w   (dword_FF9414).w
                move.w  #$24,4(a5)                      ; '$'
locret_4D006:                                           ; CODE XREF: Boss_BugmaxSpecialAttackFinish+12   j
                rts
; End of function Boss_BugmaxSpecialAttackFinish
; Manual angle control via input buttons
Boss_BugmaxManualAngleControl:
                btst    #2,(word_FFF706).w              ; was: sub_4D008
                beq.s   loc_4D016
                addi.w  #-2,(dword_FF9410).w
loc_4D016:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4D024
                addi.w  #2,(dword_FF9410).w
loc_4D024:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+14   j
                cmpi.w  #$40,(dword_FF9410).w           ; '@'
                blt.w   loc_4D036
                move.w  #$40,(dword_FF9410).w           ; '@'
                bra.s   loc_4D046
; ---------------------------------------------------------------------------
loc_4D036:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+22   j
                cmpi.w  #$FFC0,(dword_FF9410).w
                bge.w   loc_4D046
                move.w  #$FFC0,(dword_FF9410).w
loc_4D046:                                              ; CODE XREF: Boss_BugmaxManualAngleControl+2C   j
                                        ; Boss_BugmaxManualAngleControl+34   j
                bsr.w   Boss_BugmaxUpdateSegmentAngles
                rts
; End of function Boss_BugmaxManualAngleControl
; Updates all boss body segment angles
Boss_BugmaxUpdateSegmentAngles:                         ; CODE XREF: Boss_BugmaxMovementPhase1+8   p  ; was: sub_4D04C
                                        ; Boss_BugmaxAngleCalculateAttack+E   p
                move.w  (dword_FF9410).w,d0
                add.w   d0,d0
                bpl.s   loc_4D056
                neg.w   d0
loc_4D056:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+6   j
                move.w  #$40,(dword_FF9410+2).w         ; '@'
                sub.w   d0,(dword_FF9410+2).w
                move.w  (dword_FF9410).w,d0
                moveq   #0,d6
                movea.w #(word_FFC8C0-M68K_RAM),a0
                move.w  #2,d7
loc_4D06E:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+2E   j
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                lea     $60(a0),a0
                dbf     d7,loc_4D06E
                move.w  #2,d7
loc_4D082:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+44   j
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                add.w   d0,d6
                lea     $60(a0),a0
                dbf     d7,loc_4D082
                move.w  #1,d7
loc_4D098:                                              ; CODE XREF: Boss_BugmaxUpdateSegmentAngles+5C   j
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                add.w   d0,d6
                add.w   d0,d6
                lea     $60(a0),a0
                dbf     d7,loc_4D098
                rts
; End of function Boss_BugmaxUpdateSegmentAngles
; Sets up second attack stance
Boss_BugmaxEnterAttackStance2:                          ; DATA XREF: ROM:0004C41C   o  ; was: sub_4D0AE
                bsr.w   Boss_BugmaxUpdateMovement
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxEnterAttackStance2
; Waits for attack counter to reach $20
Boss_BugmaxWaitCounter32:                               ; DATA XREF: ROM:0004C41E   o  ; was: sub_4D0BE
                bsr.w   Boss_BugmaxUpdateMovement
                addq.w  #1,(dword_FF9408).w
                cmpi.w  #$20,(dword_FF9408).w           ; ' '
                bne.s   locret_4D0D2
                addq.w  #2,4(a5)
locret_4D0D2:                                           ; CODE XREF: Boss_BugmaxWaitCounter32+E   j
                rts
; End of function Boss_BugmaxWaitCounter32
; Smart positioning based on camera scroll
Boss_BugmaxSmartPositioning:                            ; DATA XREF: ROM:0004C420   o  ; was: sub_4D0D4
                bsr.w   Boss_BugmaxUpdateMovement
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                clr.b   (dword_FF9418+1).w
                bclr    #0,(dword_FF941C).w
                bset    #0,(dword_FF9418+1).w
                tst.b   (dword_FF9418+3).w
                bne.w   loc_4D124
                cmpi.b  #2,(dword_FF9424+2).w
                bne.w   loc_4D124
                cmpi.w  #$3C0,(dword_FFA900).w
                beq.s   loc_4D12A
                cmpi.w  #$460,(dword_FFA900).w
                beq.s   loc_4D13C
                btst    #2,(word_FFF706).w
                bne.s   loc_4D12A
                btst    #3,(word_FFF706).w
                bne.s   loc_4D13C
loc_4D124:                                              ; CODE XREF: Boss_BugmaxSmartPositioning+22   j
                                        ; Boss_BugmaxSmartPositioning+2C   j
                clr.w   (dword_FF9424).w
                rts
; ---------------------------------------------------------------------------
loc_4D12A:                                              ; CODE XREF: Boss_BugmaxSmartPositioning+36   j
                                        ; Boss_BugmaxSmartPositioning+46   j
                move.w  (dword_FFA900).w,d0
                add.w   (word_FF8248).w,d0
                addi.w  #$D0,d0
                move.w  d0,(dword_FF9424).w
                rts
; ---------------------------------------------------------------------------
loc_4D13C:                                              ; CODE XREF: Boss_BugmaxSmartPositioning+3E   j
                                        ; Boss_BugmaxSmartPositioning+4E   j
                move.w  (dword_FFA900).w,d0
                add.w   (word_FF8248).w,d0
                addi.w  #-$D0,d0
                move.w  d0,(dword_FF9424).w
                rts
; End of function Boss_BugmaxSmartPositioning
; Chases player until within distance
Boss_BugmaxDistanceChasePlayer:                         ; DATA XREF: ROM:0004C422   o  ; was: sub_4D14E
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                jsr     (Physics_CalculateDistanceTo).l
                cmpi.w  #$20,d0                         ; ' '
                bcs.s   loc_4D170
                bclr    #0,(dword_FF941C).w
                bne.s   loc_4D170
                subq.w  #1,$48(a5)
                bne.s   locret_4D184
loc_4D170:                                              ; CODE XREF: Boss_BugmaxDistanceChasePlayer+12   j
                                        ; Boss_BugmaxDistanceChasePlayer+1A   j
                move.w  #8,$48(a5)
                clr.b   (dword_FF9418+1).w
                bset    #1,(dword_FF9418+1).w
                addq.w  #2,4(a5)
locret_4D184:                                           ; CODE XREF: Boss_BugmaxDistanceChasePlayer+20   j
                rts
; End of function Boss_BugmaxDistanceChasePlayer
; 8 frame delay before next attack phase
Boss_BugmaxAttackDelay:                                 ; DATA XREF: ROM:0004C424   o  ; was: sub_4D186
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,$48(a5)
                bne.s   locret_4D19A
                move.w  #8,$4C(a5)
                addq.w  #2,4(a5)
locret_4D19A:                                           ; CODE XREF: Boss_BugmaxAttackDelay+8   j
                rts
; End of function Boss_BugmaxAttackDelay
; Updates movement and spawns vertical projectile
Boss_BugmaxProjectileVerticalAttack:                    ; DATA XREF: ROM:0004C426   o  ; was: sub_4D19C
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxVerticalControl
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D1BA
                bsr.w   Projectile_InitBugmaxSine
                move.w  #8,$48(a5)
                addq.w  #2,4(a5)
locret_4D1BA:                                           ; CODE XREF: Boss_BugmaxProjectileVerticalAttack+E   j
                rts
; End of function Boss_BugmaxProjectileVerticalAttack
; Handles horizontal AI movement with attack loop counter
Boss_BugmaxHorizontalAttackLoop:                        ; DATA XREF: ROM:0004C428   o  ; was: sub_4D1BC
                bsr.w   Boss_BugmaxUpdateMovement
                bsr.w   Boss_BugmaxHorizontalAI
                subq.w  #1,$48(a5)
                bne.s   locret_4D1D4
                subq.w  #1,$4C(a5)
                beq.s   loc_4D1D6
                subq.w  #2,4(a5)
locret_4D1D4:                                           ; CODE XREF: Boss_BugmaxHorizontalAttackLoop+C   j
                rts
; ---------------------------------------------------------------------------
loc_4D1D6:                                              ; CODE XREF: Boss_BugmaxHorizontalAttackLoop+12   j
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxHorizontalAttackLoop
; Manages state transition based on global timer
Boss_BugmaxTimedStateTransition:                        ; DATA XREF: ROM:0004C42A   o  ; was: sub_4D1DC
                bsr.w   Boss_BugmaxUpdateMovement
                subq.w  #1,(dword_FF9408).w
                cmpi.w  #$C,(dword_FF9408).w
                bne.s   locret_4D1F0
                addq.w  #2,4(a5)
locret_4D1F0:                                           ; CODE XREF: Boss_BugmaxTimedStateTransition+E   j
                rts
; End of function Boss_BugmaxTimedStateTransition
; Resets boss state machine to specific phase
Boss_BugmaxResetState:                                  ; DATA XREF: ROM:0004C42C   o  ; was: sub_4D1F2
                bsr.w   Boss_BugmaxUpdateMovement
                move.w  #$24,4(a5)                      ; '$'
                rts
; End of function Boss_BugmaxResetState
; Checks landing condition
Boss_BugmaxLandCheck:                                   ; DATA XREF: ROM:0004C42E   o  ; was: sub_4D1FE
                bsr.w   Boss_BugmaxUpdateMovement
                tst.w   (dword_FF9400).w
                bmi.s   locret_4D226
                cmpi.w  #$20,(dword_FF9400).w           ; ' '
                bgt.s   locret_4D226
                clr.b   $21(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #2,4(a5)
locret_4D226:                                           ; CODE XREF: Boss_BugmaxLandCheck+8   j
                                        ; Boss_BugmaxLandCheck+10   j
                rts
; End of function Boss_BugmaxLandCheck
; Flash effect on landing
Boss_BugmaxLandFlash:                                   ; DATA XREF: ROM:0004C430   o  ; was: sub_4D228
                tst.b   (dword_FF9418+3).w
                bne.s   loc_4D272
                subq.w  #2,$48(a5)
                bmi.s   loc_4D272
                move.w  $48(a5),d0
                andi.w  #$1E,d0
                move.w  word_4D252(pc,d0.w),d0
                move.w  #$3F,d5                         ; '?'
                move.w  #$E000,d7
                lea     (word_FFE300).w,a0
                jmp     (Gfx_ApplyPaletteFade).l
; ---------------------------------------------------------------------------
word_4D252:     dc.w    0, 2, 4, 6, 8, $A, $C, $E, $E, $C, $A, 8, 6, 4, 2, 0
                                        ; DATA XREF: Boss_BugmaxLandFlash+14   r
; ---------------------------------------------------------------------------
loc_4D272:                                              ; CODE XREF: Boss_BugmaxLandFlash+4   j
                                        ; Boss_BugmaxLandFlash+A   j
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxLandFlash
; Scatters all boss parts
Boss_BugmaxScatterParts:                                ; DATA XREF: ROM:0004C432   o  ; was: sub_4D27E
                subq.w  #1,$48(a5)
                bne.w   locret_4D302
                move.w  #$CF80,d6
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$D,d7
loc_4D292:                                              ; CODE XREF: Boss_BugmaxScatterParts+3E   j
                move.w  #$344,(a0)
                move.w  d6,2(a0)
                clr.b   $21(a0)
                move.w  #$FFFE,$1C(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4D292
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
loc_4D2C8:                                              ; CODE XREF: Boss_BugmaxScatterParts+76   j
                move.w  #$344,(a0)
                move.w  #1,$5C(a0)
                clr.b   $21(a0)
                move.w  #$FFFE,$1C(a0)
                jsr     (RandomNumber).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                move.w  d0,$18(a0)
                lea     $60(a0),a0
                dbf     d7,loc_4D2C8
                move.w  #$FFFA,$1C(a5)
                addq.w  #2,4(a5)
locret_4D302:                                           ; CODE XREF: Boss_BugmaxScatterParts+4   j
                rts
; End of function Boss_BugmaxScatterParts
; Boss falls off screen
Boss_BugmaxFallOffScreen:                               ; DATA XREF: ROM:0004C434   o  ; was: sub_4D304
                cmpi.w  #$80,$14(a5)
                bgt.w   loc_4D3D4
                move.w  #$530,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                andi.w  #$7FFF,2(a5)
                clr.l   $1C(a5)
                move.w  #2,(dword_FF9408).w
                move.w  #$40,(dword_FF940C).w           ; '@'
                move.w  #$40,(dword_FF940C+2).w         ; '@'
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_4D372
                jsr     (Projectile_InitType88).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                move.b  $20(a5),$20(a0)
                andi.w  #$7FFF,$E(a0)
                addq.b  #4,$20(a0)
                move.l  #off_E953C,8(a0)
locret_4D372:                                           ; CODE XREF: Boss_BugmaxFallOffScreen+42   j
                rts
; End of function Boss_BugmaxFallOffScreen
; Wait timer state
Boss_BugmaxWaitTimer:                                   ; DATA XREF: ROM:0004C436   o  ; was: sub_4D374
                subq.w  #1,$48(a5)
                bne.s   locret_4D37E
                addq.w  #2,4(a5)
locret_4D37E:                                           ; CODE XREF: Boss_BugmaxWaitTimer+4   j
                rts
; End of function Boss_BugmaxWaitTimer
; Boss rises up
Boss_BugmaxRiseUp:                                      ; DATA XREF: ROM:0004C438   o  ; was: sub_4D380
                addi.l  #$800,$1C(a5)
                cmpi.l  #$8000,$1C(a5)
                bcs.s   locret_4D39C
                move.w  #$5C,(word_FF80C2).w            ; '\'
                addq.w  #2,4(a5)
locret_4D39C:                                           ; CODE XREF: Boss_BugmaxRiseUp+10   j
                rts
; End of function Boss_BugmaxRiseUp
; Boss falls down
Boss_BugmaxFallDown:                                    ; DATA XREF: ROM:0004C43A   o  ; was: sub_4D39E
                bsr.w   Boss_BugmaxCalculateWave
                move.l  (dword_FF9400).w,d0
                asr.l   #4,d0
                move.l  d0,$18(a5)
                cmpi.w  #$170,$14(a5)
                blt.s   locret_4D3C2
                move.b  #1,(byte_FF830E).w
                clr.w   (a5)
                move.w  #$1000,2(a5)
locret_4D3C2:                                           ; CODE XREF: Boss_BugmaxFallDown+14   j
                rts
; End of function Boss_BugmaxFallDown
; Falling debris with trail
