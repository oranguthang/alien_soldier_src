Debug_ValkirieCompositeViewerMain:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_50FA6
                tst.w   4(a5)
                beq.w   Debug_ValkirieViewerDispatchState
                tst.w   8(a5)
                beq.s   Debug_ValkirieViewerDispatchState
                jsr     (Gfx_ProcessDefaultColorFade).l
Debug_ValkirieViewerDispatchState:                      ; CODE XREF: Debug_ValkirieCompositeViewerMain+4   j  ; was: loc_50FBA
                                        ; Debug_ValkirieCompositeViewerMain+C   j
                move.w  4(a5),d0
                movea.w Debug_ValkirieViewerStateTable(pc,d0.w),a0
                adda.l  #Debug_ValkirieViewerIdle,a0
                jmp     (a0)
; End of function Debug_ValkirieCompositeViewerMain
; ---------------------------------------------------------------------------
Debug_ValkirieViewerStateTable: dc.w    Debug_ValkirieViewerInitialize-Debug_ValkirieViewerIdle  ; was: off_50FCA
                                        ; DATA XREF: Debug_ValkirieCompositeViewerMain+18   r
                dc.w    Debug_ValkirieViewerUpdate-Debug_ValkirieViewerIdle

Debug_ValkirieViewerIdle:                               ; CODE XREF: Debug_ValkirieViewerInitialize+4   j  ; was: nullsub_119
                                        ; Debug_ValkirieViewerFaceLeft+4   j
                rts
; End of function Debug_ValkirieViewerIdle

; Initialize the interactive Valkirie composite-sprite viewer
Debug_ValkirieViewerInitialize:                         ; DATA XREF: ROM:Debug_ValkirieViewerStateTable   o  ; was: sub_50FD0
                tst.w   (DataLoaderControl).w
                bmi.w   Debug_ValkirieViewerIdle
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$14,d7
                movea.l #Boss_ValkirieMetaspriteDescriptors,a0
                movea.l #Boss_ValkiriePartRadii,a1
                movea.l #Boss_ValkiriePartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$3EC,(a5)
                move.w  #$CC00,2(a5)
                clr.w   6(a5)
                move.w  #0,$176(a5)
                move.w  #$100,$356(a5)
                move.w  #$10,d0
                move.w  #$4300,d1
                move.w  #$C000,d2
                move.w  d0,$7E0(a5)
                move.w  d2,$7E2(a5)
                move.w  d1,$7EE(a5)
                move.b  #$20,$800(a5)                   ; ' '
                move.l  #Debug_ValkirieViewerPartPairMappingA,$7E8(a5)
                move.w  d0,$840(a5)
                move.w  d2,$842(a5)
                move.w  d1,$84E(a5)
                move.b  #$1C,$860(a5)
                move.l  #Debug_ValkirieViewerPartPairMappingC,$848(a5)
                move.w  d0,$8A0(a5)
                move.w  d2,$8A2(a5)
                move.w  d1,$8AE(a5)
                move.b  #$28,$8C0(a5)                   ; '('
                move.l  #Debug_ValkirieViewerPartPairMappingA,$8A8(a5)
                move.w  d0,$900(a5)
                move.w  d2,$902(a5)
                move.w  d1,$90E(a5)
                move.b  #$24,$920(a5)                   ; '$'
                move.l  #Debug_ValkirieViewerPartPairMappingC,$908(a5)
                move.w  #$C300,d1
                move.w  d0,$960(a5)
                move.w  d2,$962(a5)
                move.w  d1,$96E(a5)
                move.b  #$18,$980(a5)
                move.l  #Debug_ValkirieViewerFixedPartMapping,$968(a5)
                move.w  d0,$9C0(a5)
                move.w  d2,$9C2(a5)
                move.w  d1,$9CE(a5)
                move.b  #$18,$9E0(a5)
                move.l  #Debug_ValkirieViewerExtendedGunMapping,$9C8(a5)
                movea.l #Boss_ValkirieObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                bsr.w   Debug_ValkirieViewerLoadLeftTiles
                bra.w   *+4
; ---------------------------------------------------------------------------
Debug_ValkirieViewerConfigureInteractiveState:          ; CODE XREF: Debug_ValkirieViewerInitialize+106   j  ; was: loc_510DA
                move.w  #2,4(a5)
                move.w  #$120,$10(a5)
                move.w  #$E0,$14(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$CD40,$48(a5)
                move.w  #$120,$730(a5)
                move.w  #$CF20,$4A(a5)
                move.w  #$148,$914(a5)
; Interactive viewer update: facing, angle, pose, linked parts, and screen anchor
Debug_ValkirieViewerUpdate:                             ; DATA XREF: ROM:00050FCC   o  ; was: loc_51116
                tst.w   (MessageSequenceState).w
                bne.s   Debug_ValkirieViewerProcessFacingInput
                move.b  #1,(SceneSequenceFlags).w
Debug_ValkirieViewerProcessFacingInput:                 ; CODE XREF: Debug_ValkirieViewerInitialize+14A   j  ; was: loc_51122
                btst    #6,(ControllerHeldState).w
                beq.s   Debug_ValkirieViewerCheckFaceRightInput
                bsr.w   Debug_ValkirieViewerFaceLeft
Debug_ValkirieViewerCheckFaceRightInput:                ; CODE XREF: Debug_ValkirieViewerInitialize+158   j  ; was: loc_5112E
                btst    #5,(ControllerHeldState).w
                beq.s   Debug_ValkirieViewerCheckAngleIncreaseInput
                bsr.w   Debug_ValkirieViewerFaceRight
Debug_ValkirieViewerCheckAngleIncreaseInput:            ; CODE XREF: Debug_ValkirieViewerInitialize+164   j  ; was: loc_5113A
                btst    #2,(ControllerHeldState).w
                beq.s   Debug_ValkirieViewerCheckAngleDecreaseInput
                addq.b  #1,$29F(a5)
Debug_ValkirieViewerCheckAngleDecreaseInput:            ; CODE XREF: Debug_ValkirieViewerInitialize+170   j  ; was: loc_51146
                btst    #3,(ControllerHeldState).w
                beq.s   Debug_ValkirieViewerPreparePoseUpdate
                subq.b  #1,$29F(a5)
Debug_ValkirieViewerPreparePoseUpdate:                  ; CODE XREF: Debug_ValkirieViewerInitialize+17C   j  ; was: loc_51152
                andi.w  #$1FE,$56(a5)
                lea     Debug_ValkirieViewerPoseScript(pc),a1
                nop
                bra.w   *+4
; ---------------------------------------------------------------------------
Debug_ValkirieViewerUpdatePoseAndParts:                 ; CODE XREF: Debug_ValkirieViewerInitialize+18E   j  ; was: loc_51162
                bsr.w   Debug_ValkirieViewerAdvancePoseScript
                moveq   #$14,d7
                jsr     (Sprite_SetMetaspriteTraversalPointers).l
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                move.w  #$FFF3,d7
                tst.w   $54(a5)
                beq.s   Debug_ValkirieViewerPositionUpperPartPair
                neg.w   d7
Debug_ValkirieViewerPositionUpperPartPair:              ; CODE XREF: Debug_ValkirieViewerInitialize+1AA   j  ; was: loc_5117E
                move.w  d7,d0
                add.w   $640(a5),d0
                move.w  d0,$820(a5)
                move.w  d0,$880(a5)
                move.l  #Debug_ValkirieViewerPartPairMappingA,$7E8(a5)
                move.b  $38(a0),d0
                ext.w   d0
                cmpi.w  #4,d0
                bmi.s   Debug_ValkirieViewerStoreUpperPartPairPosition
                move.l  #Debug_ValkirieViewerPartPairMappingB,$7E8(a5)
Debug_ValkirieViewerStoreUpperPartPairPosition:         ; CODE XREF: Debug_ValkirieViewerInitialize+1CE   j  ; was: loc_511A8
                add.w   $644(a5),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$824(a5)
                move.w  d0,$884(a5)
                move.w  d7,d0
                add.w   $7C0(a5),d0
                move.w  d0,$8E0(a5)
                move.w  d0,$940(a5)
                move.l  #Debug_ValkirieViewerPartPairMappingA,$8A8(a5)
                move.b  $3C(a0),d0
                ext.w   d0
                cmpi.w  #4,d0
                bmi.s   Debug_ValkirieViewerStoreLowerPartPairPosition
                move.l  #Debug_ValkirieViewerPartPairMappingB,$8A8(a5)
Debug_ValkirieViewerStoreLowerPartPairPosition:         ; CODE XREF: Debug_ValkirieViewerInitialize+208   j  ; was: loc_511E2
                add.w   $7C4(a5),d0
                addi.w  #$28,d0                         ; '('
                move.w  d0,$8E4(a5)
                move.w  d0,$944(a5)
                moveq   #$18,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bclr    #4,$54E(a5)
                bclr    #4,$6CE(a5)
                moveq   #6,d5
                tst.w   $54(a5)
                beq.s   Debug_ValkirieViewerPositionGun
                neg.w   d5
Debug_ValkirieViewerPositionGun:                        ; CODE XREF: Debug_ValkirieViewerInitialize+23C   j  ; was: loc_51210
                add.w   $D0(a5),d5
                move.w  $D4(a5),d6
                addi.w  #-8,d6
                move.b  $29F(a5),d3
                cmpi.b  #$70,d3                         ; 'p'
                bmi.s   Debug_ValkirieViewerPositionExtendedGun
                addi.w  #2,d5
                addi.w  #-6,d6
                move.w  d5,$970(a5)
                move.w  d6,$974(a5)
                bsr.w   Debug_ValkirieViewerUpdateGunMapping
                bra.w   Debug_ValkirieViewerUpdateScreenAnchor
; ---------------------------------------------------------------------------
Debug_ValkirieViewerPositionExtendedGun:                ; CODE XREF: Debug_ValkirieViewerInitialize+254   j  ; was: loc_5123E
                lea     (Math_SineTable).l,a0
                move.l  #Debug_ValkirieViewerExtendedGunMapping,$9C8(a5)
                bset    #3,$9CE(a5)
                move.w  #$1A0,d7
                tst.w   $54(a5)
                beq.s   Debug_ValkirieViewerCalculateExtendedGunOffsets
                bclr    #3,$9CE(a5)
                move.w  #$160,d7
Debug_ValkirieViewerCalculateExtendedGunOffsets:        ; CODE XREF: Debug_ValkirieViewerInitialize+28A   j  ; was: loc_51266
                move.w  -$80(a0,d7.w),d1
                move.w  (a0,d7.w),d2
                ext.w   d3
                muls.w  d3,d1
                muls.w  d3,d2
                move.l  d1,$9D4(a5)
                move.l  d2,$9D0(a5)
                asr.l   #2,d1
                asr.l   #2,d2
                move.l  d1,$974(a5)
                move.l  d2,$970(a5)
                add.w   d5,$970(a5)
                add.w   d6,$974(a5)
                addq.w  #4,d5
                addi.w  #-$C,d6
                add.w   d5,$9D0(a5)
                add.w   d6,$9D4(a5)
Debug_ValkirieViewerUpdateScreenAnchor:                 ; CODE XREF: Debug_ValkirieViewerInitialize+26A   j  ; was: loc_5129E
                move.w  #$A7,d0
                tst.w   $54(a5)
                beq.s   Debug_ValkirieViewerStoreScreenAnchor
                move.w  #$97,d0
Debug_ValkirieViewerStoreScreenAnchor:                  ; CODE XREF: Debug_ValkirieViewerInitialize+2D6   j  ; was: loc_512AC
                sub.w   $70(a5),d0
                move.w  $74(a5),d1
                addi.w  #$3C,d1                         ; '<'
                move.w  d0,(SecondaryCameraXPos).w
                move.w  d1,(SecondaryCameraYPos).w
                jsr     (Boss_ClampSharedScreenPosition).l
                rts
; End of function Debug_ValkirieViewerInitialize
; Face the composite sprite left and load its left-facing tiles
Debug_ValkirieViewerFaceLeft:                           ; CODE XREF: Debug_ValkirieViewerInitialize+15A   p  ; was: sub_512C8
                tst.w   $54(a5)
                beq.w   Debug_ValkirieViewerIdle
                clr.w   $54(a5)
                moveq   #3,d0
                bclr    d0,$E(a5)
                bclr    d0,$CE(a5)
                bclr    d0,$60E(a5)
                bclr    d0,$78E(a5)
                bclr    d0,$5AE(a5)
                bclr    d0,$72E(a5)
                bclr    d0,$7EE(a5)
                bclr    d0,$84E(a5)
                bclr    d0,$8AE(a5)
                bclr    d0,$90E(a5)
                bclr    d0,$96E(a5)
                bra.w   Debug_ValkirieViewerLoadLeftTiles
; End of function Debug_ValkirieViewerFaceLeft
; Face the composite sprite right and load its right-facing tiles
Debug_ValkirieViewerFaceRight:                          ; CODE XREF: Debug_ValkirieViewerInitialize+166   p  ; was: sub_51306
                tst.w   $54(a5)
                bne.w   Debug_ValkirieViewerIdle
                move.w  #$100,$54(a5)
                moveq   #3,d0
                bset    d0,$E(a5)
                bset    d0,$CE(a5)
                bset    d0,$60E(a5)
                bset    d0,$78E(a5)
                bset    d0,$5AE(a5)
                bset    d0,$72E(a5)
                bset    d0,$7EE(a5)
                bset    d0,$84E(a5)
                bset    d0,$8AE(a5)
                bset    d0,$90E(a5)
                bset    d0,$96E(a5)
                lea     Debug_ValkirieViewerRightTileTransfer(pc),a0
                nop
                jmp     Tilemap_QueueIndexedColumns
; End of function Debug_ValkirieViewerFaceRight
; Load the viewer's left-facing tile set
Debug_ValkirieViewerLoadLeftTiles:                      ; CODE XREF: Debug_ValkirieViewerInitialize+102   p  ; was: sub_5134E
                                        ; Debug_ValkirieViewerFaceLeft+3A   j
                lea     Debug_ValkirieViewerLeftTileTransfer(pc),a0
                nop
                jmp     Tilemap_QueueIndexedColumns
; End of function Debug_ValkirieViewerLoadLeftTiles
; ---------------------------------------------------------------------------
Debug_ValkirieViewerRightTileTransfer:  dc.w    $6100, $2000, $102, $2829, $2A2B, $2C2D  ; was: word_5135A
                                        ; DATA XREF: Debug_ValkirieViewerFaceRight+3C   o
Debug_ValkirieViewerLeftTileTransfer:   dc.w    $6100, $2000, $102, $8A89, $8C8B, $8E8D  ; was: word_51366
                                        ; DATA XREF: Debug_ValkirieViewerLoadLeftTiles   o

; Copy the gun-part transform and select its mapping from the aiming angle
Debug_ValkirieViewerUpdateGunMapping:                   ; CODE XREF: Debug_ValkirieViewerInitialize+266   p  ; was: sub_51372
                move.w  $2B0(a5),$9D0(a5)
                move.w  $2B4(a5),$9D4(a5)
                move.w  $2AE(a5),$9CE(a5)
                move.w  $2F6(a5),d0
                addi.w  #$10,d0
                asr.w   #3,d0
                andi.w  #$1C,d0
                move.l  Debug_ValkirieViewerGunMappingTable(pc,d0.w),$9C8(a5)
                rts
; End of function Debug_ValkirieViewerUpdateGunMapping
; ---------------------------------------------------------------------------
Debug_ValkirieViewerGunMappingTable:    dc.l    Debug_ValkirieViewerGunMapping0  ; DATA XREF: Debug_ValkirieViewerUpdateGunMapping+20   r  ; was: off_5139A
                dc.l    Debug_ValkirieViewerGunMapping1
                dc.l    Debug_ValkirieViewerGunMapping2
                dc.l    Debug_ValkirieViewerGunMapping3
                dc.l    Debug_ValkirieViewerGunMapping4
                dc.l    Debug_ValkirieViewerGunMapping5
                dc.l    Debug_ValkirieViewerGunMapping6
                dc.l    Debug_ValkirieViewerGunMapping7

; Interpret pose commands and update all sixteen composite-part values
Debug_ValkirieViewerAdvancePoseScript:                  ; CODE XREF: Debug_ValkirieViewerInitialize:Debug_ValkirieViewerUpdatePoseAndParts   p  ; was: sub_513BA
                clr.b   $23E(a5)
                tst.w   $C(a5)
                bpl.s   Debug_ValkirieViewerTickPoseInterpolation
Debug_ValkirieViewerReadNextPoseCommand:                ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+24   j  ; was: loc_513C4
                                        ; Debug_ValkirieViewerAdvancePoseScript+44   j
                move.w  $58(a5),d0
                bmi.w   Debug_ValkirieViewerStorePoseComponents
                cmpi.b  #$80,(a1,d0.w)
                bne.s   Debug_ValkirieViewerCheckPoseControlCommand
                move.b  1(a1,d0.w),$23E(a5)
                addq.w  #2,$58(a5)
                bra.s   Debug_ValkirieViewerReadNextPoseCommand
; ---------------------------------------------------------------------------
Debug_ValkirieViewerCheckPoseControlCommand:            ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+18   j  ; was: loc_513E0
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   Debug_ValkirieViewerHandlePoseLoopCommand
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
Debug_ValkirieViewerHandlePoseLoopCommand:              ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+2E   j  ; was: loc_513F0
                cmpi.w  #$FFFF,d3
                bne.s   Debug_ValkirieViewerBeginPoseCommandInterpolation
                clr.w   $58(a5)
                clr.w   $29C(a5)
                bra.s   Debug_ValkirieViewerReadNextPoseCommand
; ---------------------------------------------------------------------------
Debug_ValkirieViewerBeginPoseCommandInterpolation:      ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+3A   j  ; was: loc_51400
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #Debug_ValkirieViewerPoseTargets,d0
                movea.l d0,a0
                bsr.w   Debug_ValkirieViewerBeginPoseInterpolation
                moveq   #0,d0
                move.b  (dword_FF8040).w,d0
                move.w  d0,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,$29C(a5)
                tst.w   $C(a5)
                bmi.s   Debug_ValkirieViewerStorePoseComponents
Debug_ValkirieViewerTickPoseInterpolation:              ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+8   j  ; was: loc_51432
                subq.w  #1,$C(a5)
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                moveq   #$10,d7
                jsr     (Anim_ApplyInterpolationStep).l
Debug_ValkirieViewerStorePoseComponents:                ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+E   j  ; was: loc_51442
                                        ; Debug_ValkirieViewerAdvancePoseScript+76   j
                move.w  #$1FE,d7
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                move.b  8(a0),d0
                ext.w   d0
                addq.w  #6,d0
                move.w  d0,$B4(a5)
                move.b  $C(a0),d0
                ext.w   d0
                addi.w  #8,d0
                move.w  d0,$114(a5)
                move.b  $10(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  d0,$236(a5)
                move.b  $14(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$296(a5)
                move.w  d1,$2F6(a5)
                move.b  $18(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                move.w  d0,$416(a5)
                move.b  $1C(a0),d1
                asl.w   #1,d1
                add.w   d0,d1
                and.w   d7,d1
                move.w  d1,$476(a5)
                move.w  d1,$4D6(a5)
                move.b  $20(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$536(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$596(a5)
                move.w  d0,$5F6(a5)
                move.w  d0,$656(a5)
                move.b  $28(a0),d0
                ext.w   d0
                move.w  d0,$654(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$6B6(a5)
                move.b  $30(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.w  d0,$776(a5)
                move.w  d0,$7D6(a5)
                move.b  $34(a0),d0
                ext.w   d0
                move.w  d0,$7D4(a5)
                rts
; End of function Debug_ValkirieViewerAdvancePoseScript
; Initialize interpolation deltas for the next viewer pose command
Debug_ValkirieViewerBeginPoseInterpolation:             ; CODE XREF: Debug_ValkirieViewerAdvancePoseScript+5C   p  ; was: sub_51514
                lea     Debug_ValkirieViewerPoseBaseValues(pc),a1
                nop
                moveq   #$10,d7
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a2
                move.w  d3,$C(a5)
                jmp     Anim_CalculateInterpolationDeltas
; End of function Debug_ValkirieViewerBeginPoseInterpolation
; Load interpolation durations for the sixteen viewer pose components
Debug_ValkirieViewerLoadPoseDurations:                  ; was: sub_5152A
                moveq   #$10,d7
                movea.w #(SharedPatternRow0Long0-M68K_RAM),a1
                jmp     Anim_LoadFrameDelays
; End of function Debug_ValkirieViewerLoadPoseDurations
; ---------------------------------------------------------------------------
Debug_ValkirieViewerPoseBaseValues: dc.b    $40, $C0, $80, $80, $A0, $80, $A0, $80, $80, $A0, $80, 0, $A0, $80, $80, $80  ; was: byte_51536
                                        ; DATA XREF: Debug_ValkirieViewerBeginPoseInterpolation   o
Debug_ValkirieViewerPoseScript: dc.b    $10, $18, 0, 0, $10, $10, 0, 0, $10, $18, 0, $10, $20, $20, 0, $10  ; was: byte_51546
                                        ; DATA XREF: Debug_ValkirieViewerInitialize+188   o
                dc.b    $FF, $FF, 8, $C, 0, $20, $12, $12, 0, $20, 2, 4, 0, $30, 9, 9
                dc.b    0, $30, $10, $30, 0, $20, $FF, $FE
Debug_ValkirieViewerPoseTargets:    dc.b    $BC, $4A, $11, $F, $2C, $98, $78, $A8, $E8, $36, 3, $90, $54, 4, 2, 3  ; was: byte_5156E
                                        ; DATA XREF: Debug_ValkirieViewerAdvancePoseScript+54   o
                dc.b    $CA, $41, $E, $12, $30, $96, $78, $AC, $D8, $1A, $FC, $A0, $3A, $FC, $A, 0
                dc.b    $C0, $46, $10, $12, 8, $F8, $50, $18, $E0, $50, 4, $A0, $20, 4, 0, 4
                dc.b    $B8, $3C, $11, $F, $F8, $C8, $48, 8, $C0, $40, $FC, $A0, $14, 4, 0, 6
