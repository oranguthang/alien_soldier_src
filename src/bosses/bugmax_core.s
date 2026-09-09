; Main handler for Bugmax boss
Boss_BugmaxMain:                                        ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4BEBC
                tst.w   4(a5)
                beq.w   Boss_BugmaxDispatchMainState
                lea     (word_3E3C).l,a2
                jsr     (Gfx_ProcessColorFade).l
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$58(a5)
                move.w  $5E(a5),d0
                lea     Boss_BugmaxGeometryModeHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxMain
; ---------------------------------------------------------------------------
Boss_BugmaxGeometryModeHandlers:    dc.w    Boss_BugmaxUpdateLinkedChainGeometry-*  ; DATA XREF: Boss_BugmaxMain+24   o  ; was: off_4BEE8
                dc.w    Boss_BugmaxUpdateReverseLinkedChainGeometry-*
                dc.w    Boss_BugmaxUpdateForwardLinkedChainGeometry-*
                dc.w    Boss_BugmaxUpdatePerspectiveAndLinkedGeometry-*

; Update controller anchors, linked-chain positions, and smoothed joint angles
Boss_BugmaxUpdateLinkedChainGeometry:                   ; DATA XREF: ROM:Boss_BugmaxGeometryModeHandlers   o  ; was: sub_4BEF0
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
Boss_BugmaxProjectForwardLinkedChainLoop:               ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+58   j  ; was: loc_4BF2E
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,Boss_BugmaxProjectForwardLinkedChainLoop
                move.w  $10(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
Boss_BugmaxShiftPrimaryPositionHistoryLoop:             ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+6E   j  ; was: loc_4BF58
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,Boss_BugmaxShiftPrimaryPositionHistoryLoop
                move.w  -$C(a0),d4
                move.w  -2(a0),d5
                move.w  d4,d0
                move.w  (dword_FFC694).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
                cmpi.w  #$1C0,d2
                bcs.s   Boss_BugmaxClampFirstJointAngleMinimum
                move.w  #$1C0,d2
                bra.s   Boss_BugmaxStoreFirstJointAngle
; ---------------------------------------------------------------------------
Boss_BugmaxClampFirstJointAngleMinimum:                 ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+92   j  ; was: loc_4BF8A
                cmpi.w  #$140,d2
                bhi.s   Boss_BugmaxStoreFirstJointAngle
                move.w  #$140,d2
Boss_BugmaxStoreFirstJointAngle:                        ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+98   j  ; was: loc_4BF94
                                        ; Boss_BugmaxUpdateLinkedChainGeometry+9E   j
                move.w  d2,(word_FFC6CC).w
                move.w  d5,d0
                move.w  (dword_FFC6F4).w,d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
                cmpi.w  #$C0,d2
                bcs.s   Boss_BugmaxClampSecondJointAngleMinimum
                move.w  #$C0,d2
                bra.s   Boss_BugmaxStoreSecondJointAngle
; ---------------------------------------------------------------------------
Boss_BugmaxClampSecondJointAngleMinimum:                ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+C0   j  ; was: loc_4BFB8
                cmpi.w  #$40,d2                         ; '@'
                bhi.s   Boss_BugmaxStoreSecondJointAngle
                move.w  #$40,d2                         ; '@'
Boss_BugmaxStoreSecondJointAngle:                       ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+C6   j  ; was: loc_4BFC2
                                        ; Boss_BugmaxUpdateLinkedChainGeometry+CC   j
                move.w  d2,(word_FFC72C).w
                move.w  d2,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
Boss_BugmaxShiftJointAngleHistoryRowsLoop:              ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+EE   j  ; was: loc_4BFD0
                move.w  #3,d6
Boss_BugmaxShiftJointAngleHistoryRowLoop:               ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+EA   j  ; was: loc_4BFD4
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,Boss_BugmaxShiftJointAngleHistoryRowLoop
                dbf     d7,Boss_BugmaxShiftJointAngleHistoryRowsLoop
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (word_FF9600).w,a1
                move.w  #$10,d6
                move.w  #3,d7
; Copy smoothed joint angles into four linked-part records
Boss_BugmaxCopySmoothedAnglesToLinkedPartsLoop:         ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+110   j  ; was: loc_4BFF2
                lea     $60(a0),a0
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                dbf     d7,Boss_BugmaxCopySmoothedAnglesToLinkedPartsLoop
                bra.w   Boss_BugmaxCheckForcedFinalState
; End of function Boss_BugmaxUpdateLinkedChainGeometry
; Project the linked chain in reverse record order
Boss_BugmaxUpdateReverseLinkedChainGeometry:            ; DATA XREF: ROM:0004BEEA   o  ; was: sub_4C008
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  #$1F0,(dword_FFA90C).w
                movea.w #(word_FFC860-M68K_RAM),a1
                movea.w #(word_FFC800-M68K_RAM),a0
                move.w  #3,d7
; Project each reverse-chain segment from the preceding record
Boss_BugmaxProjectReverseLinkedChainLoop:               ; CODE XREF: Boss_BugmaxUpdateReverseLinkedChainGeometry+4C   j  ; was: loc_4C02A
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                move.w  $50(a1),d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$100,d0
                bsr.w   Math_BugmaxCalculatePolarOffset
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     -$60(a0),a0
                dbf     d7,Boss_BugmaxProjectReverseLinkedChainLoop
                movea.w a5,a0
                move.l  (dword_FFC6F0).w,d3
                move.l  (dword_FFC6F4).w,d4
                move.w  (word_FFC730).w,d2
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$100,d0
                bsr.w   Math_BugmaxCalculatePolarOffset
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                bra.w   Boss_BugmaxCheckForcedFinalState
; End of function Boss_BugmaxUpdateReverseLinkedChainGeometry
; Project the linked chain in forward record order
Boss_BugmaxUpdateForwardLinkedChainGeometry:            ; DATA XREF: ROM:0004BEEC   o  ; was: sub_4C09A
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
Boss_BugmaxProjectForwardChainFromPreviousPartLoop:     ; CODE XREF: Boss_BugmaxUpdateForwardLinkedChainGeometry+5A   j  ; was: loc_4C0D2
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                move.w  $50(a0),d2
                move.w  $4C(a0),d0
                bsr.w   Math_BugmaxCalculatePolarOffset
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,Boss_BugmaxProjectForwardChainFromPreviousPartLoop
                bra.w   Boss_BugmaxUpdatePositionAndAngleHistories
; End of function Boss_BugmaxUpdateForwardLinkedChainGeometry
; Update perspective rows, position histories, and both linked chains
Boss_BugmaxUpdatePerspectiveAndLinkedGeometry:          ; DATA XREF: ROM:0004BEEE   o  ; was: sub_4C0FC
                move.w  #$190,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  #$60,d0                         ; '`'
                move.w  #$5F,d7                         ; '_'
                movea.w #(byte_FF9520-M68K_RAM),a0
Boss_BugmaxInitializePerspectiveRowsLoop:               ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+1C   j  ; was: loc_4C114
                move.w  d0,(a0)+
                subq.w  #2,d0
                dbf     d7,Boss_BugmaxInitializePerspectiveRowsLoop
                tst.w   (dword_FF9400).w
                beq.w   Boss_BugmaxUpdatePerspectiveParametersAndGeometry
                tst.w   (dword_FF9400).w
                bmi.w   Boss_BugmaxInitializeNegativePerspectiveSlope
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
Boss_BugmaxFillPerspectiveRowsBackwardLoop:             ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+82   j  ; was: loc_4C170
                cmpa.w  a1,a0
                beq.w   Boss_BugmaxUpdatePerspectiveParametersAndGeometry
                sub.l   d2,d1
                move.l  d1,d4
                swap    d4
                move.w  d4,-(a0)
                dbf     d7,Boss_BugmaxFillPerspectiveRowsBackwardLoop
                bra.s   Boss_BugmaxUpdatePerspectiveParametersAndGeometry
; ---------------------------------------------------------------------------
Boss_BugmaxInitializeNegativePerspectiveSlope:          ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+2C   j  ; was: loc_4C184
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
Boss_BugmaxFillPerspectiveRowsForwardLoop:              ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+E0   j  ; was: loc_4C1D0
                cmpa.w  a1,a0
                beq.s   Boss_BugmaxUpdatePerspectiveParametersAndGeometry
                add.l   d2,d1
                move.l  d1,d4
                swap    d4
                move.w  d4,(a0)+
                dbf     d7,Boss_BugmaxFillPerspectiveRowsForwardLoop
Boss_BugmaxUpdatePerspectiveParametersAndGeometry:      ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+24   j  ; was: loc_4C1E0
                                        ; Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+76   j
                bsr.w   Gfx_BugmaxApplyWavePaletteOffset
                movea.w #(word_FFC680-M68K_RAM),a0
                cmpi.w  #$10,(a0)
                bne.w   Boss_BugmaxCheckForcedFinalState
                move.l  $10(a5),d3
                move.l  $14(a5),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                move.w  #4,d7
                movea.w #(word_FFC6E0-M68K_RAM),a0
                movea.w a5,a1
Boss_BugmaxProjectPrimaryLinkedChainLoop:               ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+12C   j  ; was: loc_4C20E
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_CalculatePolarPosition
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,Boss_BugmaxProjectPrimaryLinkedChainLoop
Boss_BugmaxUpdatePositionAndAngleHistories:             ; CODE XREF: Boss_BugmaxUpdateForwardLinkedChainGeometry+5E   j  ; was: loc_4C22C
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                swap    d0
                move.w  $14(a5),d0
                lea     (word_FF95E0).w,a0
                move.w  #7,d7
Boss_BugmaxShiftPositionHistoryLoop:                    ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+14C   j  ; was: loc_4C242
                move.l  (a0),d1
                move.l  d0,(a0)+
                move.l  d1,d0
                dbf     d7,Boss_BugmaxShiftPositionHistoryLoop
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
                bsr.w   Math_BugmaxCalculatePolarOffset
                swap    d0
                swap    d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
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
                bsr.w   Math_BugmaxCalculatePolarOffset
                swap    d0
                swap    d1
                sub.w   $10(a5),d0
                sub.w   $14(a5),d1
                jsr     (Math_CalculateDirectionIndex).l
                move.w  d2,(word_FFC72C).w
                move.w  d2,d0
                lea     (word_FF9600).w,a0
                move.w  #7,d7
Boss_BugmaxShiftPrimaryAngleHistoryRowsLoop:            ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+1E8   j  ; was: loc_4C2D6
                move.w  #3,d6
Boss_BugmaxShiftPrimaryAngleHistoryRowLoop:             ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+1E4   j  ; was: loc_4C2DA
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,Boss_BugmaxShiftPrimaryAngleHistoryRowLoop
                dbf     d7,Boss_BugmaxShiftPrimaryAngleHistoryRowsLoop
                movea.w #(word_FFC6E0-M68K_RAM),a0
                lea     (word_FF9600).w,a1
                move.w  #$10,d6
                move.w  #3,d7
Boss_BugmaxCopyPrimaryAnglesToLinkedPartsLoop:          ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+20A   j  ; was: loc_4C2F8
                lea     $60(a0),a0
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                dbf     d7,Boss_BugmaxCopyPrimaryAnglesToLinkedPartsLoop
                move.w  (word_FFC6CC).w,d0
                add.w   d0,d0
                lea     (word_FF9680).w,a0
                move.w  #7,d7
Boss_BugmaxShiftSecondaryAngleHistoryRowsLoop:          ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+22A   j  ; was: loc_4C318
                move.w  #7,d6
Boss_BugmaxShiftSecondaryAngleHistoryRowLoop:           ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+226   j  ; was: loc_4C31C
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d6,Boss_BugmaxShiftSecondaryAngleHistoryRowLoop
                dbf     d7,Boss_BugmaxShiftSecondaryAngleHistoryRowsLoop
                movea.w #(word_FFC8C0-M68K_RAM),a0
                lea     (word_FF9680).w,a1
                move.w  #$10,d6
                move.w  #7,d7
Boss_BugmaxCopySecondaryAnglesToLinkedPartsLoop:        ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+24C   j  ; was: loc_4C33A
                lea     (a1,d6.w),a1
                move.w  -2(a1),$4C(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_BugmaxCopySecondaryAnglesToLinkedPartsLoop
                move.w  #7,d7
                movea.w #(word_FFC8C0-M68K_RAM),a0
                move.w  (dword_FF9410+2).w,d2
                movea.w #(word_FFC680-M68K_RAM),a1
Boss_BugmaxProjectSecondaryLinkedChainLoop:             ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+28E   j  ; was: loc_4C35C
                tst.b   (dword_FF9418+2).w
                bne.s   Boss_BugmaxUseSharedSecondaryChainAngle
                move.w  $4C(a0),d0
                bra.s   Boss_BugmaxProjectSecondaryChainPart
; ---------------------------------------------------------------------------
Boss_BugmaxUseSharedSecondaryChainAngle:                ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+264   j  ; was: loc_4C368
                move.w  (dword_FF9414).w,d0
Boss_BugmaxProjectSecondaryChainPart:                   ; CODE XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+26A   j  ; was: loc_4C36C
                add.w   $4E(a0),d0
                move.l  $10(a1),d3
                move.l  $14(a1),d4
                bsr.w   Math_BugmaxCalculatePolarOffset
                move.l  d0,$10(a0)
                move.l  d1,$14(a0)
                movea.w a0,a1
                lea     $60(a0),a0
                dbf     d7,Boss_BugmaxProjectSecondaryLinkedChainLoop
                bsr.w   Boss_BugmaxToggleCentralPartMapping
Boss_BugmaxCheckForcedFinalState:                       ; CODE XREF: Boss_BugmaxUpdateLinkedChainGeometry+114   j  ; was: loc_4C392
                                        ; Boss_BugmaxUpdateReverseLinkedChainGeometry+8E   j
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_BugmaxDispatchMainState
                btst    #1,(byte_FF80EC).w
                bne.w   Boss_BugmaxDispatchMainState
                tst.w   (word_FF8200).w
                bne.s   Boss_BugmaxDispatchMainState
                move.b  #2,(byte_FF80EC).w
Boss_BugmaxEnterForcedFinalState:                       ; was: loc_4C3B0
                bset    #0,$5A(a5)
                move.w  #$56,4(a5)                      ; 'V'
                move.w  #1,(dword_FF9428+2).w
                bset    #0,(byte_FFA272).w
                bra.w   *+4
; ---------------------------------------------------------------------------
; Main state dispatcher for Bugmax boss
Boss_BugmaxDispatchMainState:                           ; CODE XREF: Boss_BugmaxMain+4   j  ; was: loc_4C3CC
                                        ; Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+29C   j
                move.w  4(a5),d0
                lea     Boss_BugmaxMainStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_BugmaxUpdatePerspectiveAndLinkedGeometry
; ---------------------------------------------------------------------------
Boss_BugmaxMainStateHandlers:   dc.w    Boss_BugmaxInitializeEncounterState-*  ; DATA XREF: Boss_BugmaxUpdatePerspectiveAndLinkedGeometry+2D4   o  ; was: off_4C3D8
                dc.w    Boss_BugmaxInitializeHorizontalJitterState-*
                dc.w    Boss_BugmaxUpdateHorizontalJitterState-*
                dc.w    Boss_BugmaxWaitAfterJitterAndCheckVictory-*
                dc.w    Boss_BugmaxWaitForOpeningTransition-*
                dc.w    Boss_BugmaxWaitForFirstOpeningScrollThreshold-*
                dc.w    Boss_BugmaxWaitForSecondOpeningScrollThreshold-*
                dc.w    Boss_BugmaxInitializeLinkedPartSpin-*
                dc.w    Boss_BugmaxAccelerateLinkedPartSpin-*
                dc.w    Boss_BugmaxReverseLinkedPartSpin-*
                dc.w    Boss_BugmaxSlowLinkedPartSpin-*
                dc.w    Boss_BugmaxPrepareJumpState-*
                dc.w    Boss_BugmaxInitializeBattleObjectChains-*
                dc.w    Boss_BugmaxRotateLinkedAssemblyToward140-*
                dc.w    Boss_BugmaxRotateLinkedAssemblyToward180AndStartBattle-*
                dc.w    Gfx_BugmaxLoadTimedBattleTileSet-*
                dc.w    Gfx_BugmaxLoadQueuedBattleTileSet-*
                dc.w    Boss_BugmaxSettleChainBendAtBattleBaseline-*
                dc.w    Boss_BugmaxSelectBattlePattern-*
                dc.w    Boss_BugmaxBeginSpreadVolleyStance-*
                dc.w    Boss_BugmaxIncreaseWaveStepForSpreadVolley-*
                dc.w    Boss_BugmaxApproachSpreadVolleyTarget-*
                dc.w    Boss_BugmaxSpawnSpreadProjectile-*
                dc.w    Boss_BugmaxRepeatSpreadProjectileVolley-*
                dc.w    Boss_BugmaxReduceWaveStepAfterSpreadVolley-*
                dc.w    Boss_BugmaxSetChainStrikeApproachTarget-*
                dc.w    Boss_BugmaxApproachChainStrikeTarget-*
                dc.w    Boss_BugmaxBeginAimedChainStrike-*
                dc.w    Boss_BugmaxAnimateAndAimChainStrike-*
                dc.w    Boss_BugmaxExtendAimedChainStrike-*
                dc.w    Boss_BugmaxHoldExtendedChainStrike-*
                dc.w    Boss_BugmaxRetractAimedChainStrike-*
                dc.w    Boss_BugmaxResetChainStrikeBend-*
                dc.w    Boss_BugmaxSettleChainAfterStrike-*
                dc.w    Boss_BugmaxBeginSineProjectileVolleyStance-*
                dc.w    Boss_BugmaxIncreaseWaveStepForSineVolley-*
                dc.w    Boss_BugmaxChooseSineVolleySideTarget-*
                dc.w    Boss_BugmaxApproachSineVolleyTarget-*
                dc.w    Boss_BugmaxPrepareSineProjectileVolley-*
                dc.w    Boss_BugmaxSpawnSineProjectile-*
                dc.w    Boss_BugmaxRepeatSineProjectileVolley-*
                dc.w    Boss_BugmaxReduceWaveStepAfterSineVolley-*
                dc.w    Boss_BugmaxReturnToBattlePatternSelection-*
                dc.w    Boss_BugmaxWaitForFinalWaveBand-*
                dc.w    Boss_BugmaxRunFinalPalettePulse-*
                dc.w    Boss_BugmaxScatterLinkedParts-*
                dc.w    Boss_BugmaxRiseWithFinalParticles-*
                dc.w    Boss_BugmaxWaitBeforeFinalDescent-*
                dc.w    Boss_BugmaxAccelerateFinalDescent-*
                dc.w    Boss_BugmaxUpdateFinalWaveDescentAndCompleteEncounter-*

; Initialize the controller, six linked parts, and smoothing buffers
Boss_BugmaxInitializeEncounterState:                    ; DATA XREF: ROM:Boss_BugmaxMainStateHandlers   o  ; was: sub_4C43C
                tst.b   (word_FFF720).w
                bmi.w   Boss_BugmaxInitializeEncounterReturn
                addq.w  #2,4(a5)
                move.b  #4,(byte_FFA420).w
                move.w  #$300,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
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
Boss_BugmaxInitializeLinkedPartLoop:                    ; CODE XREF: Boss_BugmaxInitializeEncounterState+144   j  ; was: loc_4C51E
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
                lea     Boss_BugmaxLinkedPartDescriptors(pc),a1
                nop
                move.w  (a1,d6.w),$50(a0)
                move.l  4(a1,d6.w),8(a0)
                addq.w  #8,d6
                lea     $60(a0),a0
                dbf     d7,Boss_BugmaxInitializeLinkedPartLoop
                bsr.w   Gfx_BugmaxLoadInitialTiles
                move.w  #$168,d0
                sub.w   $5C(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$128,d0
                move.w  d0,(dword_FFA90C).w
                lea     (word_FF9600).w,a0
                move.w  #7,d7
Boss_BugmaxClearAngleHistoryRowsLoop:                   ; CODE XREF: Boss_BugmaxInitializeEncounterState+17C   j  ; was: loc_4C5AC
                move.w  #3,d6
; Fill one four-word angle-history row with $80
Boss_BugmaxClearAngleHistoryRowLoop:                    ; CODE XREF: Boss_BugmaxInitializeEncounterState+178   j  ; was: loc_4C5B0
                move.w  #$80,(a0)+
                dbf     d6,Boss_BugmaxClearAngleHistoryRowLoop
                dbf     d7,Boss_BugmaxClearAngleHistoryRowsLoop
Boss_BugmaxInitializeEncounterReturn:                   ; CODE XREF: Boss_BugmaxInitializeEncounterState+4   j  ; was: locret_4C5BC
                rts
; End of function Boss_BugmaxInitializeEncounterState
; ---------------------------------------------------------------------------
Boss_BugmaxLinkedPartDescriptors:   dc.w    $5C         ; field_0  ; was: stru_4C5BE
                                        ; DATA XREF: Boss_BugmaxInitializeEncounterState+12C   o
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

; Load the initial Bugmax tile set
Gfx_BugmaxLoadInitialTiles:                             ; CODE XREF: Boss_BugmaxInitializeEncounterState+148   p  ; was: sub_4C5E6
                lea     Gfx_BugmaxInitialTileLoadDescriptor(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Gfx_BugmaxLoadInitialTiles
; ---------------------------------------------------------------------------
Gfx_BugmaxInitialTileLoadDescriptor:    dc.w    $6330, $2000, $104, $BEBF, $C2C3, $C6C7, $CACB, $CF  ; was: word_4C5F2
                                        ; DATA XREF: Gfx_BugmaxLoadInitialTiles   o

; Save the body anchor and initialize the horizontal-jitter timer
Boss_BugmaxInitializeHorizontalJitterState:             ; DATA XREF: ROM:0004C3DA   o  ; was: sub_4C602
                move.w  $5C(a5),$4A(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxInitializeHorizontalJitterState
; Alternate the body anchor by $60 while the jitter timer runs
Boss_BugmaxUpdateHorizontalJitterState:                 ; DATA XREF: ROM:0004C3DC   o  ; was: sub_4C614
                subq.w  #1,$48(a5)
                beq.s   Boss_BugmaxFinishHorizontalJitterState
                move.w  $4A(a5),d0
                move.w  (word_FFA000).w,d7
                andi.w  #2,d7
                beq.s   Boss_BugmaxStoreJitteredBodyAnchor
                addi.w  #$60,d0                         ; '`'
Boss_BugmaxStoreJitteredBodyAnchor:                     ; CODE XREF: Boss_BugmaxUpdateHorizontalJitterState+12   j  ; was: loc_4C62C
                move.w  d0,$5C(a5)
                rts
; ---------------------------------------------------------------------------
; Restore the saved body anchor and finish the jitter state
Boss_BugmaxFinishHorizontalJitterState:                 ; CODE XREF: Boss_BugmaxUpdateHorizontalJitterState+4   j  ; was: loc_4C632
                move.w  $4A(a5),$5C(a5)
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxUpdateHorizontalJitterState
; Wait after the jitter, clamp linked positions, and call the victory check
Boss_BugmaxWaitAfterJitterAndCheckVictory:              ; DATA XREF: ROM:0004C3DE   o  ; was: sub_4C644
                bsr.w   Boss_BugmaxClampOpeningObjectHorizontalPositions
                subq.w  #1,$48(a5)
                bne.s   Boss_BugmaxPostJitterWaitReturn
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
Boss_BugmaxPostJitterWaitReturn:                        ; CODE XREF: Boss_BugmaxWaitAfterJitterAndCheckVictory+8   j  ; was: locret_4C65C
                rts
; End of function Boss_BugmaxWaitAfterJitterAndCheckVictory
; Wait for the opening transition gate and enable controller collision
Boss_BugmaxWaitForOpeningTransition:                    ; DATA XREF: ROM:0004C3E0   o  ; was: sub_4C65E
                bsr.w   Boss_BugmaxClampOpeningObjectHorizontalPositions
                tst.w   (word_FF80C2).w
                bne.s   Boss_BugmaxOpeningTransitionWaitReturn
                move.b  #$D0,$21(a5)
                clr.b   (byte_FF80EC).w
                clr.w   (dword_FF9428+2).w
                subi.w  #$A0,(word_FFA970).w
                addq.w  #2,4(a5)
Boss_BugmaxOpeningTransitionWaitReturn:                 ; CODE XREF: Boss_BugmaxWaitForOpeningTransition+8   j  ; was: locret_4C680
                rts
; End of function Boss_BugmaxWaitForOpeningTransition
; Wait for the first opening scroll threshold, then replace tiles and emit debris
Boss_BugmaxWaitForFirstOpeningScrollThreshold:          ; DATA XREF: ROM:0004C3E2   o  ; was: sub_4C682
                bsr.w   Boss_BugmaxEmitOpeningHitFragmentsAndSteer
                bsr.w   Boss_BugmaxClampOpeningObjectHorizontalPositions
                cmpi.w  #$6800,(word_FF8200).w
                bhi.s   Boss_BugmaxFirstOpeningThresholdReturn
                addq.w  #2,4(a5)
                move.w  #3,d0
                bsr.w   Boss_BugmaxSpawnTransitionDebris
                bra.s   Gfx_BugmaxLoadFirstOpeningTiles
; ---------------------------------------------------------------------------
Boss_BugmaxFirstOpeningThresholdReturn:                 ; CODE XREF: Boss_BugmaxWaitForFirstOpeningScrollThreshold+E   j  ; was: locret_4C6A0
                rts
; ---------------------------------------------------------------------------
; Load the first opening-transition tile set
Gfx_BugmaxLoadFirstOpeningTiles:                        ; CODE XREF: Boss_BugmaxWaitForFirstOpeningScrollThreshold+1C   j  ; was: loc_4C6A2
                lea     Gfx_BugmaxFirstOpeningTileLoadDescriptor(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxWaitForFirstOpeningScrollThreshold
; ---------------------------------------------------------------------------
Gfx_BugmaxFirstOpeningTileLoadDescriptor:   dc.w    $6330, $2000, $104, $BEBF, $C0C3, $C4C7, $C8CB, $CF  ; was: word_4C6AE
                                        ; DATA XREF: Boss_BugmaxWaitForFirstOpeningScrollThreshold:loc_4C6A2   o

; Spawn Bugmax transition debris from selected linked records
Boss_BugmaxSpawnTransitionDebris:                       ; CODE XREF: Boss_BugmaxWaitForFirstOpeningScrollThreshold+18   p  ; was: sub_4C6BE
                                        ; Boss_BugmaxWaitForSecondOpeningScrollThreshold+20   p
                move.w  d0,d7
                subq.w  #1,d7
                clr.w   d6
; Initialize the requested number of transition-debris projectiles
Boss_BugmaxSpawnTransitionDebrisLoop:                   ; CODE XREF: Boss_BugmaxSpawnTransitionDebris+38   j  ; was: loc_4C6C4
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Boss_BugmaxTransitionDebrisSpawnReturn
                lea     Boss_BugmaxDebrisParameterTable(pc),a2
                nop
                move.w  (a2,d6.w),d0
                move.w  $E(a2,d6.w),d1
                move.w  $1C(a2,d6.w),d2
                movea.w Boss_BugmaxDebrisSourceObjectTable(pc,d6.w),a1
                move.w  $10(a1),$10(a0)
                move.w  $14(a1),$14(a0)
                jsr     (Projectile_InitBugmaxDebris).l
                addq.w  #2,d6
                dbf     d7,Boss_BugmaxSpawnTransitionDebrisLoop
Boss_BugmaxTransitionDebrisSpawnReturn:                 ; CODE XREF: Boss_BugmaxSpawnTransitionDebris+C   j  ; was: locret_4C6FA
                rts
; End of function Boss_BugmaxSpawnTransitionDebris
; ---------------------------------------------------------------------------
Boss_BugmaxDebrisSourceObjectTable: dc.w    $C620, $C6E0, $C740, $C7A0, $C680, $C800, $C860  ; was: word_4C6FC
                                        ; DATA XREF: Boss_BugmaxSpawnTransitionDebris+20   r
Boss_BugmaxDebrisParameterTable:    dc.w    $40, $40, $40, $40, $28, $28, $18  ; was: word_4C70A
                                        ; DATA XREF: Boss_BugmaxSpawnTransitionDebris+E   o
                dc.w    $20, $20, $20, $10, 8, 8, 4
                dc.w    $10, $10, $10, $10, 8, 8, 8

; Wait for the second opening scroll threshold, then replace tiles and emit debris
Boss_BugmaxWaitForSecondOpeningScrollThreshold:         ; DATA XREF: ROM:0004C3E4   o  ; was: sub_4C734
                bsr.w   Boss_BugmaxEmitOpeningHitFragmentsAndSteer
                bsr.w   Boss_BugmaxClampOpeningObjectHorizontalPositions
                cmpi.w  #$6000,(word_FF8200).w
                bhi.s   Boss_BugmaxSecondOpeningThresholdReturn
                clr.l   $18(a5)
                addq.w  #2,$5E(a5)
                addq.w  #2,4(a5)
                move.w  #7,d0
                bsr.w   Boss_BugmaxSpawnTransitionDebris
                bra.s   Gfx_BugmaxLoadSecondOpeningTiles
; ---------------------------------------------------------------------------
Boss_BugmaxSecondOpeningThresholdReturn:                ; CODE XREF: Boss_BugmaxWaitForSecondOpeningScrollThreshold+E   j  ; was: locret_4C75A
                rts
; ---------------------------------------------------------------------------
; Load the second opening-transition tile set
Gfx_BugmaxLoadSecondOpeningTiles:                       ; CODE XREF: Boss_BugmaxWaitForSecondOpeningScrollThreshold+24   j  ; was: loc_4C75C
                lea     Gfx_BugmaxSecondOpeningTileLoadDescriptor(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Boss_BugmaxWaitForSecondOpeningScrollThreshold
; ---------------------------------------------------------------------------
Gfx_BugmaxSecondOpeningTileLoadDescriptor:  dc.w    $6330, $2000, $104, $BCBD, $C1, $C5, $C9, $CD  ; was: word_4C768
                                        ; DATA XREF: Boss_BugmaxWaitForSecondOpeningScrollThreshold:loc_4C75C   o

; Initialize synchronized linked-part rotation
Boss_BugmaxInitializeLinkedPartSpin:                    ; DATA XREF: ROM:0004C3E6   o  ; was: sub_4C778
                move.w  (word_FFC72C).w,$4C(a5)
                move.w  #$118,$4A(a5)
                move.w  #$80,(word_FFC8AC).w
                bsr.w   Boss_BugmaxSynchronizeLinkedPartAngles
                addq.w  #2,4(a5)
                rts
; End of function Boss_BugmaxInitializeLinkedPartSpin
; Accelerate linked-part angular offsets over eight timed steps
Boss_BugmaxAccelerateLinkedPartSpin:                    ; DATA XREF: ROM:0004C3E8   o  ; was: sub_4C794
                movea.w #(word_FFC680-M68K_RAM),a0
                bsr.w   Boss_BugmaxSelectCentralPartFrameByAngle
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   $4A(a5),d0
                move.w  d0,(dword_FFC874).w
                move.w  (word_FFA000).w,d7
                andi.w  #7,d7
                bne.s   Boss_BugmaxLinkedPartSpinAccelerationReturn
                addq.w  #1,$48(a5)
                cmpi.w  #8,$48(a5)
                bcc.s   Boss_BugmaxFinishLinkedPartSpinAcceleration
                move.w  $48(a5),d0
                neg.w   d0
                bsr.w   Boss_BugmaxSetLinkedPartAngleOffsets
                rts
; ---------------------------------------------------------------------------
Boss_BugmaxFinishLinkedPartSpinAcceleration:            ; CODE XREF: Boss_BugmaxAccelerateLinkedPartSpin+2E   j  ; was: loc_4C7D0
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
Boss_BugmaxLinkedPartSpinAccelerationReturn:            ; CODE XREF: Boss_BugmaxAccelerateLinkedPartSpin+22   j  ; was: locret_4C7DA
                rts
; End of function Boss_BugmaxAccelerateLinkedPartSpin
; Apply a cumulative angle offset across the linked-part address table
Boss_BugmaxSetLinkedPartAngleOffsets:                   ; CODE XREF: Boss_BugmaxAccelerateLinkedPartSpin+36   p  ; was: sub_4C7DC
                                        ; Boss_BugmaxReverseLinkedPartSpin+2A   p
                move.w  #6,d7
                moveq   #0,d6
                lea     Boss_BugmaxLinkedPartAddressTable(pc),a1
                nop
; Store one linked-part angle offset and advance the accumulator
Boss_BugmaxSetLinkedPartAngleOffsetLoop:                ; CODE XREF: Boss_BugmaxSetLinkedPartAngleOffsets+16   j  ; was: loc_4C7E8
                movea.w (a1)+,a0
                move.w  d6,$4E(a0)
                add.w   d0,d6
                add.w   d0,d6
                dbf     d7,Boss_BugmaxSetLinkedPartAngleOffsetLoop
                rts
; End of function Boss_BugmaxSetLinkedPartAngleOffsets
; ---------------------------------------------------------------------------
Boss_BugmaxLinkedPartAddressTable:  dc.w    $C860, $C800, $C7A0, $C740, $C6E0, $C620, $C680  ; was: word_4C7F8
                                        ; DATA XREF: Boss_BugmaxSetLinkedPartAngleOffsets+6   o
                                        ; sub_4C806   o

; Copy the first linked-part angle to the remaining linked records
Boss_BugmaxSynchronizeLinkedPartAngles:                 ; CODE XREF: Boss_BugmaxInitializeLinkedPartSpin+12   p  ; was: sub_4C806
                lea     Boss_BugmaxLinkedPartAddressTable(pc),a1
                movea.w (a1)+,a0
                move.w  $4C(a0),d0
                move.w  #5,d7
Boss_BugmaxSynchronizeLinkedPartAngleLoop:              ; CODE XREF: Boss_BugmaxSynchronizeLinkedPartAngles+14   j  ; was: loc_4C814
                movea.w (a1)+,a0
                move.w  d0,$4C(a0)
                dbf     d7,Boss_BugmaxSynchronizeLinkedPartAngleLoop
                subi.w  #$100,(word_FFC6CC).w
                andi.w  #$1FF,(word_FFC6CC).w
                rts
; End of function Boss_BugmaxSynchronizeLinkedPartAngles
; Select the central linked-part mapping from its normalized angle
Boss_BugmaxSelectCentralPartFrameByAngle:               ; CODE XREF: Boss_BugmaxAccelerateLinkedPartSpin+4   p  ; was: sub_4C82C
                                        ; Boss_BugmaxReverseLinkedPartSpin+4   p
                move.w  $4C(a0),d0
                add.w   $4E(a0),d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                andi.w  #$F7FF,$E(a0)
                andi.w  #$EFFF,$E(a0)
                cmpi.w  #$160,d0
                bcs.s   Boss_BugmaxSelectLowerAngleCentralPartFrame
                cmpi.w  #$170,d0
                bhi.s   Boss_BugmaxSelectUpperAngleCentralPartFrame
                ori.w   #$800,$E(a0)
                move.l  #word_ECB7C,8(a0)
                rts
; ---------------------------------------------------------------------------
Boss_BugmaxSelectUpperAngleCentralPartFrame:            ; CODE XREF: Boss_BugmaxSelectCentralPartFrameByAngle+26   j  ; was: loc_4C864
                ori.w   #$800,$E(a0)
                move.l  #word_ECB88,8(a0)
                rts
; ---------------------------------------------------------------------------
Boss_BugmaxSelectLowerAngleCentralPartFrame:            ; CODE XREF: Boss_BugmaxSelectCentralPartFrameByAngle+20   j  ; was: loc_4C874
                ori.w   #$800,$E(a0)
                move.l  #word_ECB6A,8(a0)
                rts
; End of function Boss_BugmaxSelectCentralPartFrameByAngle
; Reverse and randomize linked-part angular offsets during the timed state
Boss_BugmaxReverseLinkedPartSpin:                       ; DATA XREF: ROM:0004C3EA   o  ; was: sub_4C884
                movea.w #(word_FFC680-M68K_RAM),a0
                bsr.w   Boss_BugmaxSelectCentralPartFrameByAngle
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
                bsr.w   Boss_BugmaxSetLinkedPartAngleOffsets
                subq.w  #1,$48(a5)
                bne.s   Boss_BugmaxReverseLinkedPartSpinReturn
                move.w  #$FFF8,$48(a5)
                addq.w  #2,4(a5)
Boss_BugmaxReverseLinkedPartSpinReturn:                 ; CODE XREF: Boss_BugmaxReverseLinkedPartSpin+32   j  ; was: locret_4C8C2
                rts
; End of function Boss_BugmaxReverseLinkedPartSpin
; Reduce the shared linked-part angle increment until the terminal value
Boss_BugmaxSlowLinkedPartSpin:                          ; DATA XREF: ROM:0004C3EC   o  ; was: sub_4C8C4
                move.w  $48(a5),d0
                bsr.w   Boss_BugmaxSetLinkedPartAngleOffsets
                subq.w  #1,$48(a5)
                cmpi.w  #$FFEC,$48(a5)
                bne.s   Boss_BugmaxLinkedPartSpinSlowdownReturn
                addq.w  #2,4(a5)
Boss_BugmaxLinkedPartSpinSlowdownReturn:                ; CODE XREF: Boss_BugmaxSlowLinkedPartSpin+12   j  ; was: locret_4C8DC
                rts
; End of function Boss_BugmaxSlowLinkedPartSpin
; Finish angle restoration, seed jump velocities, and play sound $E4
Boss_BugmaxPrepareJumpState:                            ; DATA XREF: ROM:0004C3EE   o  ; was: sub_4C8DE
                move.w  $48(a5),d0
                bsr.w   Boss_BugmaxSetLinkedPartAngleOffsets
                addq.w  #1,$48(a5)
                bne.s   Boss_BugmaxPrepareJumpReturn
                move.l  #$FFFA0000,(dword_FFC87C).w
                move.l  #$FFFD0000,(dword_FFC878).w
                addq.w  #2,4(a5)
                move.b  #$E4,d0
                jsr     (Sound_PlaySFX).l
Boss_BugmaxPrepareJumpReturn:                           ; CODE XREF: Boss_BugmaxPrepareJumpState+C   j  ; was: locret_4C90A
                rts
; End of function Boss_BugmaxPrepareJumpState
; Update the body anchor from the saved value and current scroll side
Boss_BugmaxUpdateBodyAnchorFromScrollPhase:             ; CODE XREF: Boss_BugmaxRotateLinkedAssemblyToward180AndStartBattle+8   p  ; was: sub_4C90C
                move.w  $4A(a5),d0
                move.w  (word_FFA000).w,d7
                btst    #0,d7
                bne.s   Boss_BugmaxAdjustBodyAnchorForScrollSide
                move.w  d0,$5C(a5)
                rts
; ---------------------------------------------------------------------------
Boss_BugmaxAdjustBodyAnchorForScrollSide:               ; CODE XREF: Boss_BugmaxUpdateBodyAnchorFromScrollPhase+C   j  ; was: loc_4C920
                cmpi.w  #$410,(dword_FFA900).w
                bcc.s   Boss_BugmaxStorePositiveBodyAnchorOffset
                subi.w  #$80,d0
                rts
; ---------------------------------------------------------------------------
Boss_BugmaxStorePositiveBodyAnchorOffset:               ; CODE XREF: Boss_BugmaxUpdateBodyAnchorFromScrollPhase+1A   j  ; was: loc_4C92E
                addi.w  #$80,d0
                move.w  d0,$5C(a5)
                rts
; End of function Boss_BugmaxUpdateBodyAnchorFromScrollPhase
