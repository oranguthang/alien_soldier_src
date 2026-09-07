Boss_BugmaxAI:                                          ; CODE XREF: Boss_BugmaxUpdateAllParts+20   j  ; was: sub_4DA22
                move.w  #$168,d0
                sub.w   (dword_FFA908).w,d0
                sub.w   $10(a5),d0
                beq.s   locret_4DA8A
                tst.w   d0
                bmi.s   loc_4DA60
                addi.l  #$4000,$18(a5)
                btst    #7,$18(a5)
                beq.s   loc_4DA4C
                addi.l  #$4000,$18(a5)
loc_4DA4C:                                              ; CODE XREF: Boss_BugmaxAI+20   j
                cmpi.l  #$FFFD8000,$18(a5)
                bgt.s   locret_4DA8A
                move.l  #$FFFD8000,$18(a5)
                bra.s   locret_4DA8A
; ---------------------------------------------------------------------------
loc_4DA60:                                              ; CODE XREF: Boss_BugmaxAI+10   j
                addi.l  #-$4000,$18(a5)
                btst    #7,$18(a5)
                bne.s   loc_4DA78
                addi.l  #-$4000,$18(a5)
loc_4DA78:                                              ; CODE XREF: Boss_BugmaxAI+4C   j
                cmpi.l  #$FFFD8000,$18(a5)
                bgt.s   locret_4DA8A
                move.l  #$FFFD8000,$18(a5)
locret_4DA8A:                                           ; CODE XREF: Boss_BugmaxAI+C   j
                                        ; Boss_BugmaxAI+32   j
                rts
; End of function Boss_BugmaxAI
; Clamps leg X positions to bounds
Boss_BugmaxClampLegPositions:                           ; CODE XREF: Boss_BugmaxVictoryCheck   p  ; was: sub_4DA8C
                                        ; sub_4C65E   p
                move.w  #$168,d2
                sub.w   (dword_FFA908).w,d2
                lea     word_4DAD2(pc),a2
                nop
                moveq   #0,d6
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
                move.w  #7,d7
loc_4DAA4:                                              ; CODE XREF: Boss_BugmaxClampLegPositions+40   j
                move.w  d2,d0
                move.w  d2,d1
                sub.w   (a2,d6.w),d0
                add.w   2(a2,d6.w),d1
                cmp.w   $10(a0),d0
                bcs.s   loc_4DABC
                move.w  d0,$10(a0)
                bra.s   Boss_BugmaxLegClampLoop
; ---------------------------------------------------------------------------
loc_4DABC:                                              ; CODE XREF: Boss_BugmaxClampLegPositions+28   j
                cmp.w   $10(a0),d1
                bhi.s   Boss_BugmaxLegClampLoop
                move.w  d1,$10(a0)
; Inner loop for leg position clamping
Boss_BugmaxLegClampLoop:                                ; CODE XREF: Boss_BugmaxClampLegPositions+2E   j  ; was: loc_4DAC6
                                        ; Boss_BugmaxClampLegPositions+34   j
                lea     $60(a0),a0
                addq.w  #4,d6
                dbf     d7,loc_4DAA4
                rts
; End of function Boss_BugmaxClampLegPositions
; ---------------------------------------------------------------------------
word_4DAD2:     dc.w    8, 8, $C, 8, $C, $C, $10, $10, $C, $10, $C, $C, 8, 8
                                        ; DATA XREF: Boss_BugmaxClampLegPositions+8   o

; Helper for 3D perspective calculation system
Boss_BugmaxPerspectiveHelper:                           ; CODE XREF: Boss_BugmaxCalculatePerspective:loc_4C1E0   p  ; was: sub_4DAEE
                move.w  (dword_FF9400).w,d0
                beq.s   locret_4DB2A
                tst.w   d0
                bpl.s   loc_4DB02
                neg.w   d0
                lea     word_4DB3E(pc),a0
                nop
                bra.s   loc_4DB08
; ---------------------------------------------------------------------------
loc_4DB02:                                              ; CODE XREF: Boss_BugmaxPerspectiveHelper+8   j
                lea     word_4DB2C(pc),a0
                nop
loc_4DB08:                                              ; CODE XREF: Boss_BugmaxPerspectiveHelper+12   j
                cmpi.w  #$40,d0                         ; '@'
                bcs.s   loc_4DB12
                move.w  #$40,d0                         ; '@'
loc_4DB12:                                              ; CODE XREF: Boss_BugmaxPerspectiveHelper+1E   j
                lsr.w   #3,d0
                add.w   d0,d0
                move.w  (a0,d0.w),d0
                move.w  #$E000,d7
                lea     (word_3E2E).l,a4
                jmp     (VBlank_SharpssteelPaletteEffect).l
; ---------------------------------------------------------------------------
locret_4DB2A:                                           ; CODE XREF: Boss_BugmaxPerspectiveHelper+4   j
                rts
; End of function Boss_BugmaxPerspectiveHelper
; ---------------------------------------------------------------------------
word_4DB2C:     dc.w    $FFF8, $FFFA, $FFFA, $FFFC, $FFFC, $FFFE, $FFFE, 0, 0
                                        ; DATA XREF: Boss_BugmaxPerspectiveHelper:loc_4DB02   o
word_4DB3E:     dc.w    8, 6, 6, 4, 4, 2, 2, 0, 0
                                        ; DATA XREF: Boss_BugmaxPerspectiveHelper+C   o

; Toggles mouth open/close sprite
Boss_BugmaxToggleMouthSprite:                           ; CODE XREF: Boss_BugmaxCalculatePerspective+292   p  ; was: sub_4DB50
                move.w  (word_FFA000).w,d7
                andi.w  #3,d7
                bne.s   locret_4DB7A
                movea.w #(word_FFC680-M68K_RAM),a0
                cmpi.l  #word_ECB28,8(a0)
                beq.s   loc_4DB72
                move.l  #word_ECB28,8(a0)
                rts
; ---------------------------------------------------------------------------
loc_4DB72:                                              ; CODE XREF: Boss_BugmaxToggleMouthSprite+16   j
                move.l  #word_ECB3A,8(a0)
locret_4DB7A:                                           ; CODE XREF: Boss_BugmaxToggleMouthSprite+8   j
                rts
; End of function Boss_BugmaxToggleMouthSprite
; Calculates polar coordinates to position
Math_CalculatePolarPosition:                            ; CODE XREF: Boss_BugmaxUpdateLegs+28   p  ; was: sub_4DB7C
                                        ; Boss_BugmaxUpdateLegs+46   p
                move.w  $50(a0),d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
loc_4DB88:                                              ; CODE XREF: Boss_BugmaxRotateParts1+3A   p
                                        ; Boss_BugmaxRotateParts1+6A   p
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a2
                move.w  word_1B494-word_1B514(a2,d0.w),d1
                move.w  (a2,d0.w),d0
                muls.w  d2,d0
                muls.w  d2,d1
                add.l   d3,d0
                add.l   d4,d1
                rts
; End of function Math_CalculatePolarPosition
; Updates boss movement
Boss_BugmaxUpdateMovement:                              ; CODE XREF: Boss_BugmaxMovementPhase1   p  ; was: sub_4DBA4
                                        ; Boss_BugmaxAttackPatternSelect+8   p
                bsr.s   Boss_BugmaxCalculateWave
                bsr.w   Boss_BugmaxHorizontalAI
                bsr.w   Boss_BugmaxVerticalControl
                rts
; End of function Boss_BugmaxUpdateMovement
; Calculates wave motion
Boss_BugmaxCalculateWave:                               ; CODE XREF: Boss_BugmaxFallDown   p  ; was: sub_4DBB0
                                        ; sub_4DBA4   p
                move.l  (dword_FF9408).w,d0
                add.l   d0,(dword_FF9404).w
                move.w  (dword_FF9404).w,d0
                andi.w  #$1FE,d0
                lea     (word_1B514).l,a0
                move.w  word_1B494-word_1B514(a0,d0.w),d0
                tst.w   d0
                bmi.s   loc_4DBD4
                muls.w  (dword_FF940C).w,d0
                bra.s   loc_4DBD8
; ---------------------------------------------------------------------------
loc_4DBD4:                                              ; CODE XREF: Boss_BugmaxCalculateWave+1C   j
                muls.w  (dword_FF940C+2).w,d0
loc_4DBD8:                                              ; CODE XREF: Boss_BugmaxCalculateWave+22   j
                move.l  d0,(dword_FF9400).w
                rts
; End of function Boss_BugmaxCalculateWave
; Horizontal AI and player tracking
Boss_BugmaxHorizontalAI:                                ; CODE XREF: Boss_BugmaxMoveAndCheckFlag+4   p  ; was: sub_4DBDE
                                        ; Boss_BugmaxProjectileAttack+4   p
                move.w  (word_FFA000).w,d0
                andi.w  #$1FE,d0
                move.l  (a0,d0.w),d6
                ext.l   d6
                bpl.s   loc_4DBF0
                neg.l   d6
loc_4DBF0:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+E   j
                asr.l   #2,d6
                move.w  (dword_FFA900).w,d0
                cmpi.w  #$410,d0
                bcc.s   loc_4DC0E
                cmpi.w  #$5E0,$58(a5)
                bgt.s   loc_4DC20
                cmpi.w  #$440,$58(a5)
                blt.s   loc_4DC2A
                bra.s   loc_4DC34
; ---------------------------------------------------------------------------
loc_4DC0E:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+1C   j
                cmpi.w  #$620,$58(a5)
                bgt.s   loc_4DC20
                cmpi.w  #$480,$58(a5)
                blt.s   loc_4DC2A
                bra.s   loc_4DC34
; ---------------------------------------------------------------------------
loc_4DC20:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+24   j
                                        ; Boss_BugmaxHorizontalAI+36   j
                move.l  #$2000,d6
                bra.w   loc_4DC9E
; ---------------------------------------------------------------------------
loc_4DC2A:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+2C   j
                                        ; Boss_BugmaxHorizontalAI+3E   j
                move.l  #$2000,d6
                bra.w   loc_4DC98
; ---------------------------------------------------------------------------
loc_4DC34:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+2E   j
                                        ; Boss_BugmaxHorizontalAI+40   j
                btst    #0,(dword_FF9418+1).w
                bne.s   loc_4DC6A
                btst    #1,(dword_FF9418+1).w
                beq.s   loc_4DC60
                tst.l   $18(a5)
                beq.w   locret_4DCDA
                move.l  #$1000,d6
                btst    #7,$18(a5)
                bne.w   loc_4DC98
                bra.w   loc_4DC9E
; ---------------------------------------------------------------------------
loc_4DC60:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+64   j
                move.w  (word_FFA000).w,d7
                andi.w  #$7F,d7
                bne.s   loc_4DCA4
loc_4DC6A:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+5C   j
                move.w  (dword_FF9424).w,d0
                beq.s   loc_4DC76
                sub.w   (dword_FFA900).w,d0
                bra.s   loc_4DC7A
; ---------------------------------------------------------------------------
loc_4DC76:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+90   j
                move.w  (word_FF8248).w,d0
loc_4DC7A:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+96   j
                sub.w   $10(a5),d0
                move.w  d0,d1
                bpl.s   loc_4DC84
                neg.w   d1
loc_4DC84:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+A2   j
                cmpi.w  #$10,d1
                bcc.s   loc_4DC90
                bset    #0,(dword_FF941C).w
loc_4DC90:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+AA   j
                tst.w   d0
                beq.s   locret_4DCDA
                tst.w   d0
                bmi.s   loc_4DC9E
loc_4DC98:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+52   j
                                        ; Boss_BugmaxHorizontalAI+7A   j
                clr.b   (dword_FF9418).w
                bra.s   loc_4DCA4
; ---------------------------------------------------------------------------
loc_4DC9E:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+48   j
                                        ; Boss_BugmaxHorizontalAI+7E   j
                move.b  #1,(dword_FF9418).w
loc_4DCA4:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+8A   j
                                        ; Boss_BugmaxHorizontalAI+BE   j
                tst.b   (dword_FF9418).w
                bne.s   loc_4DCB0
                add.l   d6,$18(a5)
                bra.s   loc_4DCB4
; ---------------------------------------------------------------------------
loc_4DCB0:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+CA   j
                sub.l   d6,$18(a5)
loc_4DCB4:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+D0   j
                cmpi.l  #$20000,$18(a5)
                blt.s   loc_4DCC8
                move.l  #$20000,$18(a5)
                bra.s   locret_4DCDA
; ---------------------------------------------------------------------------
loc_4DCC8:                                              ; CODE XREF: Boss_BugmaxHorizontalAI+DE   j
                cmpi.l  #$FFFE0000,$18(a5)
                bgt.s   locret_4DCDA
                move.l  #$FFFE0000,$18(a5)
locret_4DCDA:                                           ; CODE XREF: Boss_BugmaxHorizontalAI+6A   j
                                        ; Boss_BugmaxHorizontalAI+B4   j
                rts
; End of function Boss_BugmaxHorizontalAI
; Vertical movement control
Boss_BugmaxVerticalControl:                             ; CODE XREF: Boss_BugmaxProjectileVerticalAttack+4   p  ; was: sub_4DCDC
                                        ; Boss_BugmaxUpdateMovement+6   p
                move.l  #$2000,d7
                move.w  (dword_FF9420).w,d0
                move.w  $14(a5),d1
                cmp.w   d0,d1
                blt.s   loc_4DD14
                add.w   (dword_FF9420+2).w,d0
                cmp.w   d0,d1
                bgt.s   loc_4DD1C
                move.w  (dword_FF9404).w,d0
                subi.w  #$80,d0
                andi.w  #$1FF,d0
                cmpi.w  #$100,d0
                bcc.s   loc_4DD0E
                sub.l   d7,$1C(a5)
                bra.s   loc_4DD22
; ---------------------------------------------------------------------------
loc_4DD0E:                                              ; CODE XREF: Boss_BugmaxVerticalControl+2A   j
                add.l   d7,$1C(a5)
                bra.s   loc_4DD22
; ---------------------------------------------------------------------------
loc_4DD14:                                              ; CODE XREF: Boss_BugmaxVerticalControl+10   j
                asr.l   #1,d7
                add.l   d7,$1C(a5)
                bra.s   loc_4DD22
; ---------------------------------------------------------------------------
loc_4DD1C:                                              ; CODE XREF: Boss_BugmaxVerticalControl+18   j
                asr.l   #1,d7
                sub.l   d7,$1C(a5)
loc_4DD22:                                              ; CODE XREF: Boss_BugmaxVerticalControl+30   j
                                        ; Boss_BugmaxVerticalControl+36   j
                cmpi.l  #$20000,$1C(a5)
                blt.s   loc_4DD36
                move.l  #$20000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_4DD36:                                              ; CODE XREF: Boss_BugmaxVerticalControl+4E   j
                cmpi.l  #$FFFE0000,$1C(a5)
                bgt.s   locret_4DD48
                move.l  #$FFFE0000,$1C(a5)
locret_4DD48:                                           ; CODE XREF: Boss_BugmaxVerticalControl+62   j
                rts
; End of function Boss_BugmaxVerticalControl
; Debug control for manual angle adjustment
Boss_BugmaxDebugAngleControl:
                movea.w a5,a0                           ; was: sub_4DD4A
                btst    #2,(word_FFF706).w
                beq.s   loc_4DD5A
                addi.w  #-8,$4C(a0)
loc_4DD5A:                                              ; CODE XREF: Boss_BugmaxDebugAngleControl+8   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4DD68
                addi.w  #8,$4C(a0)
loc_4DD68:                                              ; CODE XREF: Boss_BugmaxDebugAngleControl+16   j
                andi.w  #$1FF,$4C(a0)
                rts
; End of function Boss_BugmaxDebugAngleControl
; Debug control for manual position adjustment
Boss_BugmaxDebugPositionControl:
                btst    #2,(word_FFF706).w              ; was: sub_4DD70
                beq.s   loc_4DD7E
                addi.w  #-2,$10(a5)
loc_4DD7E:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4DD8C
                addi.w  #2,$10(a5)
loc_4DD8C:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+14   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4DDAC
                btst    #5,(word_FFF706).w
                bne.s   loc_4DDA4
                addi.w  #-2,$14(a5)
                bra.s   loc_4DDAC
; ---------------------------------------------------------------------------
loc_4DDA4:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+2A   j
                addi.l  #$A0000,(dword_FF9400).w
loc_4DDAC:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+22   j
                                        ; Boss_BugmaxDebugPositionControl+32   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4DDD0
                btst    #5,(word_FFF706).w
                bne.s   loc_4DDC4
                addi.w  #2,$14(a5)
                rts
; ---------------------------------------------------------------------------
loc_4DDC4:                                              ; CODE XREF: Boss_BugmaxDebugPositionControl+4A   j
                addi.l  #-$A0000,(dword_FF9400).w
                tst.l   (dword_FF9400).w
locret_4DDD0:                                           ; CODE XREF: Boss_BugmaxDebugPositionControl+42   j
                rts
; End of function Boss_BugmaxDebugPositionControl
; Main boss handler
