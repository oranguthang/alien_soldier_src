; Destroyer MK2 scroll deformation, linked-part ring, and main state flow

Boss_DestroyerMK2Main:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_4A84E
                tst.w   4(a5)
                beq.w   Boss_DestroyerMK2DispatchMainState
                bsr.w   Gfx_DestroyerMK2UpdateForegroundScrollRows
                btst    #1,$4C(a5)
                bne.s   Boss_DestroyerMK2CheckFinalTransitionTrigger
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   Boss_DestroyerMK2CheckFinalTransitionTrigger
                move.w  $50(a5),d0
                beq.s   Boss_DestroyerMK2CheckFinalTransitionTrigger
                sub.w   d0,(word_FF8234).w
Boss_DestroyerMK2CheckFinalTransitionTrigger:           ; CODE XREF: Boss_DestroyerMK2Main+12   j  ; was: loc_4A876
                                        ; Boss_DestroyerMK2Main+1C   j
                btst    #2,(byte_FF80EC).w
                bne.s   Boss_DestroyerMK2UpdateEncounterEffects
                btst    #1,(byte_FF80EC).w
                bne.s   Boss_DestroyerMK2UpdateEncounterEffects
                tst.w   (word_FF8200).w
                bne.s   Boss_DestroyerMK2UpdateEncounterEffects
                move.b  #2,(byte_FF80EC).w
                bset    #0,$4C(a5)
                move.w  #$2A,4(a5)                      ; '*'
                bset    #0,(byte_FFA272).w
Boss_DestroyerMK2UpdateEncounterEffects:                ; CODE XREF: Boss_DestroyerMK2Main+2E   j  ; was: loc_4A8A4
                                        ; Boss_DestroyerMK2Main+36   j
                jsr     (Gfx_InitPaletteFade).l
                bsr.w   Gfx_DestroyerMK2CyclePaletteWords
                btst    #3,$4C(a5)
                beq.s   Boss_DestroyerMK2AnchorToScrollPosition
                move.w  #$C70,d0
                sub.w   (dword_FFA900).w,d0
                addi.w  #-$80,d0
                lea     (word_FFE520).w,a0
                lea     (word_FF98B0).w,a1
                move.w  #$B6,d7
Boss_DestroyerMK2WriteScrollRowsLoop:                   ; CODE XREF: Boss_DestroyerMK2Main+88   j  ; was: loc_4A8CE
                move.w  d0,(a0)
                move.w  (a1)+,d1
                add.w   d1,(a0)
                addq.w  #4,a0
                dbf     d7,Boss_DestroyerMK2WriteScrollRowsLoop
Boss_DestroyerMK2AnchorToScrollPosition:                ; CODE XREF: Boss_DestroyerMK2Main+66   j  ; was: loc_4A8DA
                lea     (word_FFE6E0).w,a0
                move.w  (a0),d0
                addi.w  #$C0,d0
                move.w  d0,$10(a5)
                move.w  $10(a5),d0
                add.w   (dword_FFA900).w,d0
                move.w  d0,$4E(a5)
Boss_DestroyerMK2DispatchMainState:                     ; CODE XREF: Boss_DestroyerMK2Main+4   j  ; was: loc_4A8F4
                move.w  4(a5),d0
                lea     Boss_DestroyerMK2MainStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2Main
; ---------------------------------------------------------------------------
Boss_DestroyerMK2MainStateHandlers: dc.w    Boss_DestroyerMK2InitializeEncounterState-*  ; DATA XREF: Boss_DestroyerMK2Main+AA   o  ; was: off_4A900
                dc.w    Boss_DestroyerMK2SetIntroPlayerModeState-*
                dc.w    Boss_DestroyerMK2LoadEncounterTilesState-*
                dc.w    Boss_DestroyerMK2InitializeScrollDeformationState-*
                dc.w    Boss_DestroyerMK2ShuffleScrollDeformationState-*
                dc.w    Boss_DestroyerMK2WriteInitialScrollBandsState-*
                dc.w    Boss_DestroyerMK2WaitBeforeCollisionEnableState-*
                dc.w    Boss_DestroyerMK2EnableLinkedCollisionState-*
                dc.w    Boss_DestroyerMK2WaitForExternalEffectState-*
                dc.w    Boss_DestroyerMK2ToggleOrbitingPartsState-*
                dc.w    Boss_DestroyerMK2CollapseOrbitingPartsState-*
                dc.w    Boss_DestroyerMK2WaitForLinkedComponentsState-*
                dc.w    Boss_DestroyerMK2SelectScrollWaveParametersState-*
                dc.w    Boss_DestroyerMK2AnimateScrollWaveState-*
                dc.w    Boss_DestroyerMK2WriteScrollWaveState-*
                dc.w    Boss_DestroyerMK2ExpandOrbitingPartsState-*
                dc.w    Boss_DestroyerMK2ResetScrollWavePhaseState-*
                dc.w    Boss_DestroyerMK2ApplySineScrollWaveState-*
                dc.w    Boss_DestroyerMK2DispatchProjectilePatternState-*
                dc.w    Boss_DestroyerMK2EnterProjectilePatternCycle-*
                dc.w    Boss_DestroyerMK2WaitThenRepeatProjectilePatterns-*
                dc.w    Boss_DestroyerMK2WaitForLinkedPartsToDeactivate-*
                dc.w    Boss_DestroyerMK2RunDebrisTransitionTimer-*
                dc.w    Gfx_DestroyerMK2FadeAndLoadFirstTransitionTiles-*
                dc.w    Gfx_DestroyerMK2FadeAndLoadSecondTransitionTiles-*
                dc.w    Boss_DestroyerMK2ClearTransitionControlFlags-*
                dc.w    Boss_DestroyerMK2ClearObjectsForNextEncounter-*
                dc.w    Boss_DestroyerMK2FinishTransitionPaletteFade-*

; Initializes encounter buffers, controller fields, and linked object records
Boss_DestroyerMK2InitializeEncounterState:              ; DATA XREF: ROM:Boss_DestroyerMK2MainStateHandlers   o  ; was: sub_4A938
                tst.w   (word_FFF720).w
                bmi.w   Boss_DestroyerMK2InitializeEncounterReturn
                addq.w  #2,4(a5)
                moveq   #0,d0
                move.l  d0,(dword_FF9404).w
                move.l  d0,(dword_FF9408).w
                move.l  d0,(dword_FF940C).w
                clr.w   (dword_FF9418).w
                lea     (word_FF9820).w,a0
                lea     (word_FF9620).w,a1
                move.w  #$7F,d7
Boss_DestroyerMK2ClearScrollBuffersLoop:                ; CODE XREF: Boss_DestroyerMK2InitializeEncounterState+2E   j  ; was: loc_4A962
                move.l  d0,(a0)+
                move.l  d0,(a1)+
                dbf     d7,Boss_DestroyerMK2ClearScrollBuffersLoop
                move.b  #4,(byte_FFA420).w
                bset    #3,$4C(a5)
                move.w  #$240,d0
                move.w  #$3DC,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$C0,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                move.w  #$118,$14(a5)
                move.b  #4,(byte_FFA95B).w
                move.b  #1,(byte_FFA95A).w
                lea     (word_FFE520).w,a0
                move.w  #$FF80,d0
                move.w  #$B7,d7
Boss_DestroyerMK2InitializeScrollRowsLoop:              ; CODE XREF: Boss_DestroyerMK2InitializeEncounterState+7A   j  ; was: loc_4A9AE
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,Boss_DestroyerMK2InitializeScrollRowsLoop
                move.b  #$40,$20(a5)                    ; '@'
                move.w  #$100,2(a5)
                move.b  #$88,$23(a5)
                move.w  #$96,$26(a5)
                move.l  #$F808E818,$2C(a5)
                move.l  #$F40CE020,$28(a5)
                move.w  #$1C,$24(a5)
                move.w  #8,(dword_FF9410).w
                movea.w #(word_FFC740-M68K_RAM),a0
                move.w  #$25C,(a0)
                move.b  #$10,$23(a0)
                move.w  #$D00,2(a0)
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  #$10,$23(a0)
                move.l  #$28E020,$2C(a0)
                move.l  #$34D030,$28(a0)
                move.w  #$FFC0,$4C(a0)
                movea.w #(word_FFC6E0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  #$10,$23(a0)
                move.l  #$D800E020,$2C(a0)
                move.l  #$CC00D030,$28(a0)
                move.w  #$40,$4C(a0)                    ; '@'
                move.b  $20(a5),d1
                move.w  #3,d7
                clr.w   d6
                movea.w #(word_FFC7A0-M68K_RAM),a0
                lea     Boss_DestroyerMK2LinkedPartDescriptors(pc),a1
                nop
Boss_DestroyerMK2InitializeLinkedPartLoop:              ; CODE XREF: Boss_DestroyerMK2InitializeEncounterState+17C   j  ; was: loc_4AA7E
                move.w  #$244,(a0)
                move.w  #$4D00,2(a0)
                move.b  #$10,$23(a0)
                move.w  #$96,$26(a0)
                move.b  d1,$20(a0)
                move.l  #word_EC2AA,8(a0)
                move.w  (a1)+,$4E(a0)
                move.w  (a1)+,$4A(a0)
                move.w  (a1)+,$4C(a0)
                move.w  (a1)+,$E(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2InitializeLinkedPartLoop
                move.w  #$D0,(dword_FF9404).w
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
                clr.w   d6
Boss_DestroyerMK2InitializeOrbitingPartLoop:            ; CODE XREF: Boss_DestroyerMK2InitializeEncounterState+1DA   j  ; was: loc_4AAC8
                move.w  #$258,(a0)
                move.w  #$CD00,2(a0)
                move.b  #$18,$23(a0)
                move.w  #$28,$26(a0)                    ; '('
                move.l  #$F808F808,$2C(a0)
                move.l  #$F010F010,$28(a0)
                move.w  #$30,$24(a0)                    ; '0'
                move.b  d1,$20(a0)
                move.l  #word_EC2D4,8(a0)
                move.w  #$EB00,$E(a0)
                move.w  d6,$4C(a0)
                addi.w  #$40,d6                         ; '@'
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2InitializeOrbitingPartLoop
Boss_DestroyerMK2InitializeEncounterReturn:             ; CODE XREF: Boss_DestroyerMK2InitializeEncounterState+4   j  ; was: locret_4AB16
                rts
; End of function Boss_DestroyerMK2InitializeEncounterState
; ---------------------------------------------------------------------------
Boss_DestroyerMK2LinkedPartDescriptors: dc.w    0, $FFD4, $FFC4, $F300  ; was: word_4AB18
                                        ; DATA XREF: Boss_DestroyerMK2InitializeEncounterState+140   o
                dc.w    2, $2C, $FFC4, $FB00
                dc.w    4, $FFD4, $3C, $E300
                dc.w    6, $2C, $3C, $EB00

; Publishes player mode 3 and advances to tile loading
Boss_DestroyerMK2SetIntroPlayerModeState:               ; DATA XREF: ROM:0004A902   o  ; was: sub_4AB38
                move.b  #3,(word_FFF7E6+1).w
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2SetIntroPlayerModeState
; Loads the encounter tile block and advances
Boss_DestroyerMK2LoadEncounterTilesState:               ; DATA XREF: ROM:0004A904   o  ; was: sub_4AB44
                addq.w  #2,4(a5)
                lea     Boss_DestroyerMK2EncounterTileLoadDescriptor(pc),a0
                nop
                jsr     (Gfx_DMATransferTiles).l
                rts
; End of function Boss_DestroyerMK2LoadEncounterTilesState
; ---------------------------------------------------------------------------
Boss_DestroyerMK2EncounterTileLoadDescriptor:   dc.w    $4480, $2000, $304, $9697, $9495, $9293, $9091, $8687, $8485, $8A8B, $8889, $8E8F, $8C8D  ; was: word_4AB56
                                        ; DATA XREF: Boss_DestroyerMK2LoadEncounterTilesState+4   o

; Waits for the intro gate, then initializes scroll-deformation state
Boss_DestroyerMK2InitializeScrollDeformationState:      ; DATA XREF: ROM:0004A906   o  ; was: sub_4AB70
                tst.b   (word_FFF720).w
                bmi.s   Boss_DestroyerMK2InitializeScrollDeformationReturn
                move.w  #8,(dword_FF940C).w
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                bsr.w   Boss_DestroyerMK2InitializeScrollIndexTable
                move.w  #$80,$48(a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2InitializeScrollDeformationReturn:     ; CODE XREF: Boss_DestroyerMK2InitializeScrollDeformationState+4   j  ; was: locret_4AB8E
                rts
; End of function Boss_DestroyerMK2InitializeScrollDeformationState
; Shuffles four scroll indices per frame during the initial delay
Boss_DestroyerMK2ShuffleScrollDeformationState:         ; DATA XREF: ROM:0004A908   o  ; was: sub_4AB90
                bsr.w   Boss_DestroyerMK2ShuffleScrollIndexPair
                bsr.w   Boss_DestroyerMK2ShuffleScrollIndexPair
                bsr.w   Boss_DestroyerMK2ShuffleScrollIndexPair
                bsr.w   Boss_DestroyerMK2ShuffleScrollIndexPair
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2ShuffleScrollDeformationReturn
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
                move.b  #$5B,d0                         ; '['
                jsr     (Sound_PlaySFX).l
Boss_DestroyerMK2ShuffleScrollDeformationReturn:        ; CODE XREF: Boss_DestroyerMK2ShuffleScrollDeformationState+20   j  ; was: locret_4ABC4
                rts
; End of function Boss_DestroyerMK2ShuffleScrollDeformationState
; Writes $E0 to four selected scroll rows per frame until all 256 are covered
Boss_DestroyerMK2WriteInitialScrollBandsState:          ; DATA XREF: ROM:0004A90A   o  ; was: sub_4ABC6
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                move.w  #$E0,d0
                bsr.w   Boss_DestroyerMK2WriteFourScrollOffsets
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   Boss_DestroyerMK2WriteInitialScrollBandsReturn
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                moveq   #0,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
Boss_DestroyerMK2WriteInitialScrollBandsReturn:         ; CODE XREF: Boss_DestroyerMK2WriteInitialScrollBandsState+22   j  ; was: locret_4ABFA
                rts
; End of function Boss_DestroyerMK2WriteInitialScrollBandsState
; Holds linked-object geometry for $10 frames before collision activation
Boss_DestroyerMK2WaitBeforeCollisionEnableState:        ; DATA XREF: ROM:0004A90C   o  ; was: sub_4ABFC
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2WaitBeforeCollisionEnableReturn
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2WaitBeforeCollisionEnableReturn:       ; CODE XREF: Boss_DestroyerMK2WaitBeforeCollisionEnableState+8   j  ; was: locret_4AC10
                rts
; End of function Boss_DestroyerMK2WaitBeforeCollisionEnableState
; Enables linked collision fields and advances to the external-effect wait
Boss_DestroyerMK2EnableLinkedCollisionState:            ; DATA XREF: ROM:0004A90E   o  ; was: sub_4AC12
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2EnableLinkedCollisionReturn
                bsr.w   Boss_DestroyerMK2SetLinkedCollisionFields
                move.w  #3,d0
                jsr     (UI_CheckVictoryCondition).l
                addq.w  #2,4(a5)
Boss_DestroyerMK2EnableLinkedCollisionReturn:           ; CODE XREF: Boss_DestroyerMK2EnableLinkedCollisionState+8   j  ; was: locret_4AC2E
                rts
; End of function Boss_DestroyerMK2EnableLinkedCollisionState
; Enables collision fields on the controller and twelve linked records
Boss_DestroyerMK2SetLinkedCollisionFields:              ; CODE XREF: Boss_DestroyerMK2EnableLinkedCollisionState+A   p  ; was: sub_4AC30
                                        ; Boss_DestroyerMK2ExpandOrbitingPartsState+2A   p
                move.b  #$D0,$21(a5)
                move.b  #$C0,(byte_FFC6A1).w
                move.b  #$C0,(byte_FFC701).w
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$B,d7
Boss_DestroyerMK2SetLinkedCollisionLoop:                ; CODE XREF: Boss_DestroyerMK2SetLinkedCollisionFields+24   j  ; was: loc_4AC4A
                move.b  #$C0,$21(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2SetLinkedCollisionLoop
                rts
; End of function Boss_DestroyerMK2SetLinkedCollisionFields
; Clears collision fields on the controller and twelve linked records
Boss_DestroyerMK2ClearLinkedCollisionFields:            ; CODE XREF: Boss_DestroyerMK2ToggleOrbitingPartsState+2E   p  ; was: sub_4AC5A
                                        ; Boss_DestroyerMK2WaitForLinkedPartsToDeactivate+22   p
                clr.b   $21(a5)
                clr.b   (byte_FFC6A1).w
                clr.b   (byte_FFC701).w
                movea.w #(word_FFC7A0-M68K_RAM),a0
                move.w  #$B,d7
Boss_DestroyerMK2ClearLinkedCollisionLoop:              ; CODE XREF: Boss_DestroyerMK2ClearLinkedCollisionFields+1C   j  ; was: loc_4AC6E
                clr.b   $21(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2ClearLinkedCollisionLoop
                rts
; End of function Boss_DestroyerMK2ClearLinkedCollisionFields
; Waits for word_FF80C2, then updates external state and orbiting-part fields
Boss_DestroyerMK2WaitForExternalEffectState:            ; DATA XREF: ROM:0004A910   o  ; was: sub_4AC7C
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                tst.w   (word_FF80C2).w
                bne.s   Boss_DestroyerMK2WaitForExternalEffectReturn
                addq.w  #2,4(a5)
                subi.w  #$A0,(word_FFA970).w
                clr.b   (byte_FF80EC).w
                movea.w #(word_FFC920-M68K_RAM),a0
                move.w  #8,d7
Boss_DestroyerMK2LowerOrbitingPartCollisionLoop:        ; CODE XREF: Boss_DestroyerMK2WaitForExternalEffectState+2A   j  ; was: loc_4AC9C
                move.b  #8,$23(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2LowerOrbitingPartCollisionLoop
Boss_DestroyerMK2WaitForExternalEffectReturn:           ; CODE XREF: Boss_DestroyerMK2WaitForExternalEffectState+8   j  ; was: locret_4ACAA
                rts
; End of function Boss_DestroyerMK2WaitForExternalEffectState
; Alternates the orbiting-part active bits before the collapse state
Boss_DestroyerMK2ToggleOrbitingPartsState:              ; DATA XREF: ROM:0004A912   o  ; was: sub_4ACAC
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                eori.w  #1,$54(a5)
                bne.s   Boss_DestroyerMK2AdvanceOrbitToggle
                move.w  #$20,4(a5)                      ; ' '
                rts
; ---------------------------------------------------------------------------
Boss_DestroyerMK2AdvanceOrbitToggle:                    ; CODE XREF: Boss_DestroyerMK2ToggleOrbitingPartsState+A   j  ; was: loc_4ACC0
                addq.w  #2,4(a5)
; Collapses the orbiting ring angle to $60, then disables the linked parts
Boss_DestroyerMK2CollapseOrbitingPartsState:            ; DATA XREF: ROM:0004A914   o  ; was: loc_4ACC4
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                bsr.s   Boss_DestroyerMK2ToggleOrbitingPartsActive
                subq.w  #4,(dword_FF9404).w
                cmpi.w  #$60,(dword_FF9404).w           ; '`'
                bcc.s   Boss_DestroyerMK2CollapseOrbitingPartsReturn
                bsr.s   Boss_DestroyerMK2DisableOrbitingParts
                bsr.s   Boss_DestroyerMK2InitializeScrollIndexTable
                bsr.w   Boss_DestroyerMK2ClearLinkedCollisionFields
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
Boss_DestroyerMK2CollapseOrbitingPartsReturn:           ; CODE XREF: Boss_DestroyerMK2ToggleOrbitingPartsState+28   j  ; was: locret_4ACE8
                rts
; End of function Boss_DestroyerMK2ToggleOrbitingPartsState
; Initializes the 256-entry scroll index table in descending order
Boss_DestroyerMK2InitializeScrollIndexTable:            ; CODE XREF: Boss_DestroyerMK2InitializeScrollDeformationState+10   p  ; was: sub_4ACEA
                                        ; Boss_DestroyerMK2ToggleOrbitingPartsState+2C   p
                move.w  #$FF,d7
                lea     (dword_FF9420).w,a0
Boss_DestroyerMK2InitializeScrollIndexLoop:             ; CODE XREF: Boss_DestroyerMK2InitializeScrollIndexTable+A   j  ; was: loc_4ACF2
                move.w  d7,(a0)+
                dbf     d7,Boss_DestroyerMK2InitializeScrollIndexLoop
                rts
; End of function Boss_DestroyerMK2InitializeScrollIndexTable
; Toggles the active bit on eight orbiting-part records
Boss_DestroyerMK2ToggleOrbitingPartsActive:             ; CODE XREF: Boss_DestroyerMK2ToggleOrbitingPartsState+1C   p  ; was: sub_4ACFA
                                        ; Boss_DestroyerMK2ExpandOrbitingPartsState+10   p
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
Boss_DestroyerMK2ToggleOrbitingPartLoop:                ; CODE XREF: Boss_DestroyerMK2ToggleOrbitingPartsActive+12   j  ; was: loc_4AD02
                eori.w  #$8000,2(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2ToggleOrbitingPartLoop
                rts
; End of function Boss_DestroyerMK2ToggleOrbitingPartsActive
; Disables eight orbiting parts and clears their collision fields
Boss_DestroyerMK2DisableOrbitingParts:                  ; CODE XREF: Boss_DestroyerMK2ToggleOrbitingPartsState+2A   p  ; was: sub_4AD12
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
Boss_DestroyerMK2DisableOrbitingPartLoop:               ; CODE XREF: Boss_DestroyerMK2DisableOrbitingParts+16   j  ; was: loc_4AD1A
                andi.w  #$7FFF,2(a0)
                clr.b   $21(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2DisableOrbitingPartLoop
                rts
; End of function Boss_DestroyerMK2DisableOrbitingParts
; Enables eight orbiting parts and sets their collision fields to $80
Boss_DestroyerMK2EnableOrbitingParts:                   ; CODE XREF: Boss_DestroyerMK2ExpandOrbitingPartsState+20   p  ; was: sub_4AD2E
                move.w  #7,d7
                movea.w #(word_FFC920-M68K_RAM),a0
Boss_DestroyerMK2EnableOrbitingPartLoop:                ; CODE XREF: Boss_DestroyerMK2EnableOrbitingParts+18   j  ; was: loc_4AD36
                ori.w   #$8000,2(a0)
                move.b  #$80,$21(a0)
                lea     $60(a0),a0
                dbf     d7,Boss_DestroyerMK2EnableOrbitingPartLoop
                rts
; End of function Boss_DestroyerMK2EnableOrbitingParts
; Waits for five linked components while shuffling the scroll-index table
Boss_DestroyerMK2WaitForLinkedComponentsState:          ; DATA XREF: ROM:0004A916   o  ; was: sub_4AD4C
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                tst.w   (word_FFC7A4).w
                bne.s   Boss_DestroyerMK2WaitForLinkedComponentsReturn
                tst.w   (word_FFC804).w
                bne.s   Boss_DestroyerMK2WaitForLinkedComponentsReturn
                tst.w   (word_FFC864).w
                bne.s   Boss_DestroyerMK2WaitForLinkedComponentsReturn
                tst.w   (word_FFC8C4).w
                bne.s   Boss_DestroyerMK2WaitForLinkedComponentsReturn
                bsr.s   Boss_DestroyerMK2ShuffleScrollIndexPair
                bsr.s   Boss_DestroyerMK2ShuffleScrollIndexPair
                bsr.s   Boss_DestroyerMK2ShuffleScrollIndexPair
                bsr.s   Boss_DestroyerMK2ShuffleScrollIndexPair
                move.w  (dword_FFFF08).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                cmpi.w  #$40,$48(a5)                    ; '@'
                bne.s   Boss_DestroyerMK2UpdateLinkedComponentWaitTimer
                move.b  #$E6,d0
                jsr     (Sound_PlaySFX).l
Boss_DestroyerMK2UpdateLinkedComponentWaitTimer:        ; CODE XREF: Boss_DestroyerMK2WaitForLinkedComponentsState+36   j  ; was: loc_4AD8E
                subq.w  #1,$48(a5)
                bne.s   Boss_DestroyerMK2WaitForLinkedComponentsReturn
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2WaitForLinkedComponentsReturn:         ; CODE XREF: Boss_DestroyerMK2WaitForLinkedComponentsState+8   j  ; was: locret_4AD9C
                                        ; Boss_DestroyerMK2WaitForLinkedComponentsState+E   j
                rts
; End of function Boss_DestroyerMK2WaitForLinkedComponentsState
; Exchanges two randomly selected entries in the scroll-index table
Boss_DestroyerMK2ShuffleScrollIndexPair:                ; CODE XREF: Boss_DestroyerMK2ShuffleScrollDeformationState   p  ; was: sub_4AD9E
                                        ; Boss_DestroyerMK2ShuffleScrollDeformationState+4   p
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                move.w  (dword_FFFF08+2).w,d1
                andi.w  #$FF,d1
                add.w   d0,d0
                add.w   d1,d1
                lea     (dword_FF9420).w,a0
                move.w  (a0,d0.w),d2
                move.w  (a0,d1.w),(a0,d0.w)
                move.w  d2,(a0,d1.w)
                rts
; End of function Boss_DestroyerMK2ShuffleScrollIndexPair
; Applies the default Destroyer MK2 palette-fade base
Gfx_DestroyerMK2ApplyPaletteFade:                       ; CODE XREF: Boss_DestroyerMK2ShuffleScrollDeformationState+18   p  ; was: sub_4ADCC
                                        ; Boss_DestroyerMK2WriteInitialScrollBandsState+C   p
                move.w  #$7000,d7
Gfx_DestroyerMK2ApplyPaletteFadeWithBase:               ; CODE XREF: Boss_DestroyerMK2AnimateScrollWaveState+14   p  ; was: loc_4ADD0
                                        ; Boss_DestroyerMK2WriteScrollWaveState+14   p
                movea.w #(word_FFE360-M68K_RAM),a0
                move.w  #$F,d5
                jsr     (Gfx_ApplyPaletteFade).l
                rts
; End of function Gfx_DestroyerMK2ApplyPaletteFade
; Writes one value to four selected scroll-offset rows and clears their velocities
Boss_DestroyerMK2WriteFourScrollOffsets:                ; CODE XREF: Boss_DestroyerMK2WriteInitialScrollBandsState+14   p  ; was: sub_4ADE0
                                        ; sub_4AEFA   p
                lea     (dword_FF9420).w,a0
                lea     (word_FF9820).w,a1
                lea     (word_FF9620).w,a2
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  #3,d7
Boss_DestroyerMK2WriteFourScrollOffsetsLoop:            ; CODE XREF: Boss_DestroyerMK2WriteFourScrollOffsets+26   j  ; was: loc_4ADF6
                move.w  (a0,d1.w),d2
                add.w   d2,d2
                move.w  d0,(a1,d2.w)
                clr.w   (a2,d2.w)
                addq.w  #2,d1
                dbf     d7,Boss_DestroyerMK2WriteFourScrollOffsetsLoop
                rts
; End of function Boss_DestroyerMK2WriteFourScrollOffsets
; Seeds alternating signed velocities in four selected scroll rows
Boss_DestroyerMK2SeedFourScrollVelocities:              ; CODE XREF: Boss_DestroyerMK2AnimateScrollWaveState+18   p  ; was: sub_4AE0C
                lea     (dword_FF9420).w,a0
                lea     (word_FF9620).w,a1
                move.w  $4A(a5),d1
                add.w   d1,d1
                move.w  #3,d7
Boss_DestroyerMK2SeedFourScrollVelocitiesLoop:          ; CODE XREF: Boss_DestroyerMK2SeedFourScrollVelocities+30   j  ; was: loc_4AE1E
                move.w  (a0,d1.w),d2
                add.w   d2,d2
                move.w  d7,d0
                andi.w  #1,d0
                beq.s   Boss_DestroyerMK2UsePositiveScrollVelocity
                move.w  #$FFFF,(a1,d2.w)
                bra.s   Boss_DestroyerMK2AdvanceScrollVelocityIndex
; ---------------------------------------------------------------------------
Boss_DestroyerMK2UsePositiveScrollVelocity:             ; CODE XREF: Boss_DestroyerMK2SeedFourScrollVelocities+1E   j  ; was: loc_4AE34
                move.w  #1,(a1,d2.w)
Boss_DestroyerMK2AdvanceScrollVelocityIndex:            ; CODE XREF: Boss_DestroyerMK2SeedFourScrollVelocities+26   j  ; was: loc_4AE3A
                addq.w  #2,d1
                dbf     d7,Boss_DestroyerMK2SeedFourScrollVelocitiesLoop
                rts
; End of function Boss_DestroyerMK2SeedFourScrollVelocities
; Integrates all 255 scroll-row velocities and relaxes positive values toward zero
Boss_DestroyerMK2IntegrateScrollVelocities:             ; CODE XREF: Boss_DestroyerMK2AnimateScrollWaveState+4   p  ; was: sub_4AE42
                                        ; Boss_DestroyerMK2WriteScrollWaveState+4   p
                move.w  #$FE,d7
                lea     (word_FF9820).w,a0
                lea     (word_FF9620).w,a1
Boss_DestroyerMK2IntegrateScrollVelocityLoop:           ; CODE XREF: Boss_DestroyerMK2IntegrateScrollVelocities+20   j  ; was: loc_4AE4E
                tst.w   (a1)
                beq.s   Boss_DestroyerMK2AdvanceScrollVelocityRow
                move.w  (a1),d0
                add.w   d0,(a0)
                tst.w   (a1)
                bmi.s   Boss_DestroyerMK2ReducePositiveScrollVelocity
                addq.w  #1,(a1)
Boss_DestroyerMK2ReducePositiveScrollVelocity:          ; CODE XREF: Boss_DestroyerMK2IntegrateScrollVelocities+16   j  ; was: loc_4AE5C
                subq.w  #1,(a1)
Boss_DestroyerMK2AdvanceScrollVelocityRow:              ; CODE XREF: Boss_DestroyerMK2IntegrateScrollVelocities+E   j  ; was: loc_4AE5E
                addq.w  #2,a0
                addq.w  #2,a1
                dbf     d7,Boss_DestroyerMK2IntegrateScrollVelocityLoop
                rts
; End of function Boss_DestroyerMK2IntegrateScrollVelocities
; Selects the next scroll-wave duration and angular velocity
Boss_DestroyerMK2SelectScrollWaveParametersState:       ; DATA XREF: ROM:0004A918   o  ; was: sub_4AE68
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                move.w  $56(a5),d0
                move.w  #$FFE0,(dword_FF9414).w
                move.w  Boss_DestroyerMK2ScrollWaveDurationTable(pc,d0.w),$48(a5)
                addq.w  #2,$56(a5)
                andi.w  #$E,$56(a5)
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2SelectScrollWaveParametersState
; ---------------------------------------------------------------------------
                dc.w    $130, $FFF0, $130, $FFF0, $90, $FFF0, $130, $90
Boss_DestroyerMK2ScrollWaveDurationTable:   dc.w    $2000, $8000, $2000, $8000, $4000, $8000, $2000, $4000  ; was: word_4AE9C
                                        ; DATA XREF: Boss_DestroyerMK2SelectScrollWaveParametersState+E   r

; Advances the current scroll wave until its 64 four-row batches are complete
Boss_DestroyerMK2AnimateScrollWaveState:                ; DATA XREF: ROM:0004A91A   o  ; was: sub_4AEAC
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                bsr.w   Boss_DestroyerMK2IntegrateScrollVelocities
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                move.w  $48(a5),d7
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFadeWithBase
                bsr.w   Boss_DestroyerMK2SeedFourScrollVelocities
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   Boss_DestroyerMK2AnimateScrollWaveReturn
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2AnimateScrollWaveReturn:               ; CODE XREF: Boss_DestroyerMK2AnimateScrollWaveState+26   j  ; was: locret_4AEDC
                rts
; End of function Boss_DestroyerMK2AnimateScrollWaveState
; Updates linked geometry, integrates row velocities, and begins a scroll-wave batch
Boss_DestroyerMK2WriteScrollWaveState:                  ; DATA XREF: ROM:0004A91C   o  ; was: sub_4AEDE
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                bsr.w   Boss_DestroyerMK2IntegrateScrollVelocities
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                move.w  $48(a5),d7
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFadeWithBase
                move.w  (dword_FF9414).w,d0
; End of function Boss_DestroyerMK2WriteScrollWaveState
; Writes four rows for the current scroll-wave batch
Boss_DestroyerMK2WriteScrollWaveBands:                  ; was: sub_4AEFA
                bsr.w   Boss_DestroyerMK2WriteFourScrollOffsets
                addq.w  #4,$4A(a5)
                cmpi.w  #$100,$4A(a5)
                bne.s   Boss_DestroyerMK2WriteScrollWaveReturn
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
Boss_DestroyerMK2WriteScrollWaveReturn:                 ; CODE XREF: Boss_DestroyerMK2WriteScrollWaveBands+E   j  ; was: locret_4AF12
                rts
; End of function Boss_DestroyerMK2WriteScrollWaveBands
; Expands the orbiting-ring angle to $D0, then restores collision fields
Boss_DestroyerMK2ExpandOrbitingPartsState:              ; DATA XREF: ROM:0004A91E   o  ; was: sub_4AF14
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                move.w  (word_FFA000).w,d0
                andi.w  #$E,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                bsr.w   Boss_DestroyerMK2ToggleOrbitingPartsActive
                addq.w  #4,(dword_FF9404).w
                cmpi.w  #$D0,(dword_FF9404).w
                bne.s   Boss_DestroyerMK2ExpandOrbitingPartsReturn
                bsr.w   Boss_DestroyerMK2EnableOrbitingParts
                moveq   #0,d0
                bsr.w   Gfx_DestroyerMK2ApplyPaletteFade
                bsr.w   Boss_DestroyerMK2SetLinkedCollisionFields
                move.w  #$12,4(a5)
Boss_DestroyerMK2ExpandOrbitingPartsReturn:             ; CODE XREF: Boss_DestroyerMK2ExpandOrbitingPartsState+1E   j  ; was: locret_4AF48
                rts
; End of function Boss_DestroyerMK2ExpandOrbitingPartsState
; Clears vertical phase and starts the sine scroll-wave delay
Boss_DestroyerMK2ResetScrollWavePhaseState:             ; DATA XREF: ROM:0004A920   o  ; was: sub_4AF4A
                clr.w   $1C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2ResetScrollWavePhaseState
; Applies a sine-derived uniform offset to the scroll-row buffer
Boss_DestroyerMK2ApplySineScrollWaveState:              ; DATA XREF: ROM:0004A922   o  ; was: sub_4AF5A
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                addi.w  #-$10,$1C(a5)
                move.w  $1C(a5),d1
                andi.w  #$1FE,d1
                beq.s   Boss_DestroyerMK2AdvanceSineScrollWave
                move.w  (dword_FF9410).w,d6
                add.w   d6,d6
                move.w  Boss_DestroyerMK2ScrollWaveBaseOffsetTable(pc,d6.w),d0
                lea     (Math_SineTable).l,a3
                move.w  Math_QuarterSineTable-Math_SineTable(a3,d1.w),d1
                bpl.s   Boss_DestroyerMK2ApplySineWaveRowOffset
                ext.l   d1
                move.w  Boss_DestroyerMK2ScrollWaveShiftTable(pc,d6.w),d2
                asl.l   d2,d1
                swap    d1
                add.w   d1,d0
Boss_DestroyerMK2ApplySineWaveRowOffset:                ; CODE XREF: Boss_DestroyerMK2ApplySineScrollWaveState+28   j  ; was: loc_4AF90
                bsr.w   Gfx_DestroyerMK2ApplyUniformScrollOffset
                beq.s   Boss_DestroyerMK2ApplySineScrollWaveReturn
                move.w  #$12,4(a5)
                rts
; ---------------------------------------------------------------------------
Boss_DestroyerMK2AdvanceSineScrollWave:                 ; CODE XREF: Boss_DestroyerMK2ApplySineScrollWaveState+12   j  ; was: loc_4AF9E
                addq.w  #2,4(a5)
                clr.w   (dword_FF941C).w
                addq.w  #2,(dword_FF9418+2).w
                andi.w  #$1E,(dword_FF9418+2).w
                move.w  (word_FF8248).w,d0
                sub.w   $10(a5),d0
                move.w  d0,$48(a5)
Boss_DestroyerMK2ApplySineScrollWaveReturn:             ; CODE XREF: Boss_DestroyerMK2ApplySineScrollWaveState+3A   j  ; was: locret_4AFBC
                rts
; End of function Boss_DestroyerMK2ApplySineScrollWaveState
; ---------------------------------------------------------------------------
Boss_DestroyerMK2ScrollWaveBaseOffsetTable: dc.w    5, 5, 5, 4, 4, 4, 3, 3, 2  ; was: word_4AFBE
                                        ; DATA XREF: Boss_DestroyerMK2ApplySineScrollWaveState+1A   r
Boss_DestroyerMK2ScrollWaveShiftTable:  dc.w    5, 5, 5, 5, 4, 4, 4, 3, 3  ; was: word_4AFD0
                                        ; DATA XREF: Boss_DestroyerMK2ApplySineScrollWaveState+2C   r

; Dispatches a nested projectile-pattern table selected by phase and timer sign
Boss_DestroyerMK2DispatchProjectilePatternState:        ; DATA XREF: ROM:0004A924   o  ; was: sub_4AFE2
                bsr.w   Boss_DestroyerMK2UpdateLinkedObjectGeometry
                move.w  (dword_FF9418+2).w,d0
                tst.w   $48(a5)
                bmi.w   Boss_DestroyerMK2DispatchNegativeTimerPattern
                move.w  d0,d0
                lea     Boss_DestroyerMK2PositiveTimerPatternHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; ---------------------------------------------------------------------------
Boss_DestroyerMK2PositiveTimerPatternHandlers:  dc.w    Boss_DestroyerMK2LinkedActivationPatternDispatch-*  ; DATA XREF: Boss_DestroyerMK2DispatchProjectilePatternState+12   o  ; was: off_4AFFC
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2TripleProjectilePatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2LinkedActivationPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectileSpreadPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2TripleProjectilePatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectileSpreadPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectileSpreadPatternDispatch-*
                dc.w    Boss_DestroyerMK2TripleProjectilePatternDispatch-*
; ---------------------------------------------------------------------------
Boss_DestroyerMK2DispatchNegativeTimerPattern:          ; CODE XREF: Boss_DestroyerMK2DispatchProjectilePatternState+C   j  ; was: loc_4B01C
                move.w  d0,d0
                lea     Boss_DestroyerMK2NegativeTimerPatternHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Boss_DestroyerMK2DispatchProjectilePatternState
; ---------------------------------------------------------------------------
Boss_DestroyerMK2NegativeTimerPatternHandlers:  dc.w    Boss_DestroyerMK2LinkedActivationPatternDispatch-*  ; DATA XREF: Boss_DestroyerMK2DispatchProjectilePatternState+3C   o  ; was: off_4B026
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2SingleLinkedActivationDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2LinkedActivationPatternDispatch-*
                dc.w    Boss_DestroyerMK2SingleLinkedActivationDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2SingleLinkedActivationDispatch-*
                dc.w    Boss_DestroyerMK2SingleLinkedActivationDispatch-*
                dc.w    Boss_DestroyerMK2ProjectileSpreadPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectedSweepPatternDispatch-*
                dc.w    Boss_DestroyerMK2ProjectileSpreadPatternDispatch-*
                dc.w    Boss_DestroyerMK2SingleLinkedActivationDispatch-*

; Advances the main state by one state-table slot
Boss_DestroyerMK2AdvanceMainState:                      ; CODE XREF: Boss_DestroyerMK2UpdateProjectedSweep+44   j  ; was: sub_4B046
                                        ; Boss_DestroyerMK2WaitBetweenTripleProjectiles+A   j
                                        ; DATA XREF:
                addq.w  #2,4(a5)
                rts
; End of function Boss_DestroyerMK2AdvanceMainState
; State machine for defeat sequence
