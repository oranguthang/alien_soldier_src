Boss_JampanDefeatExplosion:                             ; DATA XREF: ROM:0004A54C   o  ; was: sub_4A5F0
                move.w  #$C,d7
                movea.w #(word_FFC980-M68K_RAM),a0
                clr.w   d6
loc_4A5FA:                                              ; CODE XREF: Boss_JampanDefeatExplosion+28   j
                move.l  dword_4A62A(pc,d6.w),d0
                add.l   d0,$54(a0)
                add.l   d0,$54(a0)
                move.w  $54(a0),$4C(a0)
                andi.w  #$1FF,$4C(a0)
                addq.w  #4,d6
                lea     $60(a0),a0
                dbf     d7,loc_4A5FA
                subq.w  #1,$48(a5)
                bne.s   locret_4A628
                move.w  #2,4(a5)
locret_4A628:                                           ; CODE XREF: Boss_JampanDefeatExplosion+30   j
                rts
; End of function Boss_JampanDefeatExplosion
; ---------------------------------------------------------------------------
dword_4A62A:    dc.l    $800, $1000, $2000, $2000, $2000, $1000, $800
                                        ; DATA XREF: Boss_JampanDefeatExplosion:loc_4A5FA   r
                dc.l    $FFFFC000, $FFFF8000, $FFFF4000, $FFFF4000, $FFFF8000, $FFFFC000

; ===============================================================================
; DEBUG FUNCTION: Jampan Boss Debug Controller
; Source: Developer test code left in final ROM
; Description: Allows manual parameter manipulation during Jampan boss fight
; Status: Still called in final game but has no visible effect
;
; Controller Input Mapping (word_FFF706 = Controller 1 input):
; UP + A      : Decrease dword_FF9400 by 2
; UP + B      : Decrease dword_FF9404 by 2
; UP + C      : Decrease dword_FF9408 by 2
; DOWN + A    : Increase dword_FF9400 by 2
; DOWN + B    : Increase dword_FF9404 by 2
; DOWN + C    : Increase dword_FF9408 by 2
; LEFT + START : Increase dword_FF9424 by 2
; RIGHT + START: Decrease dword_FF9424 by 2
;
; Button bit mapping:
; Bit 0 = LEFT, Bit 1 = RIGHT, Bit 2 = UP, Bit 3 = DOWN
; Bit 4 = B, Bit 5 = C, Bit 6 = A, Bit 7 = START
;
; Note: This function is called from:
; - Boss_JampanDefeatCleanupInit+10 (line 88428)
; - Boss_JampanDefeatCleanupWait+4 (line 88449)
; ===============================================================================
Boss_JampanDebugController:                             ; CODE XREF: Boss_JampanDefeatCleanupInit+10   p  ; was: sub_4A65E
                                        ; Boss_JampanDefeatCleanupWait+4   p
                btst    #2,(word_FFF706).w              ; Test UP button on controller 1
                beq.s   loc_4A68A
                btst    #6,(word_FFF706).w
                beq.s   loc_4A672
                subq.w  #2,(dword_FF9400).w
loc_4A672:                                              ; CODE XREF: Boss_JampanDebugController+E   j
                btst    #4,(word_FFF706).w
                beq.s   loc_4A67E
                subq.w  #2,(dword_FF9404).w
loc_4A67E:                                              ; CODE XREF: Boss_JampanDebugController+1A   j
                btst    #5,(word_FFF706).w
                beq.s   loc_4A68A
                subq.w  #2,(dword_FF9408).w
loc_4A68A:                                              ; CODE XREF: Boss_JampanDebugController+6   j
                                        ; Boss_JampanDebugController+26   j
                btst    #3,(word_FFF706).w
                beq.s   loc_4A6B6
                btst    #6,(word_FFF706).w
                beq.s   loc_4A69E
                addq.w  #2,(dword_FF9400).w
loc_4A69E:                                              ; CODE XREF: Boss_JampanDebugController+3A   j
                btst    #4,(word_FFF706).w
                beq.s   loc_4A6AA
                addq.w  #2,(dword_FF9404).w
loc_4A6AA:                                              ; CODE XREF: Boss_JampanDebugController+46   j
                btst    #5,(word_FFF706).w
                beq.s   loc_4A6B6
                addq.w  #2,(dword_FF9408).w
loc_4A6B6:                                              ; CODE XREF: Boss_JampanDebugController+32   j
                                        ; Boss_JampanDebugController+52   j
                btst    #0,(word_FFF706).w
                beq.s   loc_4A6CA
                btst    #7,(word_FFF706).w
                beq.s   loc_4A6CA
                addq.w  #2,(dword_FF9424).w
loc_4A6CA:                                              ; CODE XREF: Boss_JampanDebugController+5E   j
                                        ; Boss_JampanDebugController+66   j
                btst    #1,(word_FFF706).w
                beq.s   locret_4A6DE
                btst    #7,(word_FFF706).w
                beq.s   locret_4A6DE
                subq.w  #2,(dword_FF9424).w
locret_4A6DE:                                           ; CODE XREF: Boss_JampanDebugController+72   j
                                        ; Boss_JampanDebugController+7A   j
                rts
; End of function Boss_JampanDebugController
; Checks boss health
Boss_JampanCheckHealth:                                 ; CODE XREF: Boss_JampanMain+4   p  ; was: sub_4A6E0
                move.w  #$A4,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$4C,d0                         ; 'L'
                move.w  d0,(dword_FFA90C).w
                rts
; End of function Boss_JampanCheckHealth
; Handles damage taken
Boss_JampanDamageHandler:                               ; CODE XREF: Boss_JampanMoveState+1E2   p  ; was: sub_4A6FA
                                        ; sub_4953E   p
                tst.l   (dword_FF940C).w
                beq.s   loc_4A708
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF9400).w
loc_4A708:                                              ; CODE XREF: Boss_JampanDamageHandler+4   j
                tst.l   (dword_FF9410).w
                beq.s   loc_4A716
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9404).w
loc_4A716:                                              ; CODE XREF: Boss_JampanDamageHandler+12   j
                tst.l   (dword_FF9414).w
                beq.s   loc_4A724
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9408).w
loc_4A724:                                              ; CODE XREF: Boss_JampanDamageHandler+20   j
                andi.w  #$1FF,(dword_FF9400).w
                andi.w  #$1FF,(dword_FF9404).w
                andi.w  #$1FF,(dword_FF9408).w
                movea.w a5,a1
                lea     (word_FFC860).w,a0
                move.w  #$F,d0
loc_4A740:                                              ; CODE XREF: Boss_JampanDamageHandler+8A   j
                lea     (Math_SineTable).l,a2
                move.w  $48(a0),d4
                add.w   (dword_FF9424).w,d4
                move.w  $4A(a0),d5
                move.w  $4C(a0),d6
                move.w  $4E(a0),d7
                add.w   (dword_FF9400).w,d5
                add.w   (dword_FF9424+2).w,d5
                add.w   (dword_FF9404).w,d6
                add.w   (dword_FF9428).w,d6
                add.w   (dword_FF9408).w,d7
                add.w   (dword_FF9428+2).w,d6
                andi.w  #$1FE,d5
                andi.w  #$1FE,d6
                andi.w  #$1FE,d7
                bsr.s   Boss_JampanFlashOnDamage
                lea     $60(a0),a0
                dbf     d0,loc_4A740
                rts
; End of function Boss_JampanDamageHandler
; Flash effect on damage
Boss_JampanFlashOnDamage:                               ; CODE XREF: Boss_JampanDefeatDebris+3C   p  ; was: sub_4A78A
                                        ; sub_4A160:loc_4A1AA   p
                move.w  -$80(a2,d5.w),d1
                muls.w  d4,d1
                swap    d1
                add.w   d1,d1
                add.w   d1,d1
                move.w  (a2,d6.w),d2
                muls.w  d2,d1
                swap    d1
                cmpi.w  #$3F,d1                         ; '?'
                blt.s   loc_4A7AA
                move.w  #$3F,d1                         ; '?'
                bra.s   loc_4A7B4
; ---------------------------------------------------------------------------
loc_4A7AA:                                              ; CODE XREF: Boss_JampanFlashOnDamage+18   j
                cmpi.w  #$FFC1,d1
                bgt.s   loc_4A7B4
                move.w  #$FFC1,d1
loc_4A7B4:                                              ; CODE XREF: Boss_JampanFlashOnDamage+1E   j
                                        ; Boss_JampanFlashOnDamage+24   j
                clr.w   d2
                move.b  $20(a1),d2
                add.w   d2,d1
                move.b  d1,$20(a0)
                cmp.b   $20(a1),d1
                bhi.s   loc_4A7CE
                ori.w   #$8000,$E(a0)
                bra.s   loc_4A7D4
; ---------------------------------------------------------------------------
loc_4A7CE:                                              ; CODE XREF: Boss_JampanFlashOnDamage+3A   j
                andi.w  #$7FFF,$E(a0)
loc_4A7D4:                                              ; CODE XREF: Boss_JampanFlashOnDamage+42   j
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
                rts
; End of function Boss_JampanFlashOnDamage
; Main boss handler
