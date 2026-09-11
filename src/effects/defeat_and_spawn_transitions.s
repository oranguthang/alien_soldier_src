Object_ClearForTransition:                              ; CODE XREF: Cutscene_FadeOutCredits+52   p  ; was: sub_268FA
                move.w  #$150,(a5)
                clr.w   4(a5)
                move.w  #$150,d0
                moveq   #0,d1
                jmp     Object_ClearAllExceptTypes
; End of function Object_ClearForTransition
; Initializes boss defeat explosion sprite at boss position
Boss_InitDefeatExplosion:                               ; CODE XREF: Boss_ShiperDefeatSequence+58   p  ; was: sub_2690E
                                        ; Boss_TerobusterDefeatFadeState+38   p
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$354,(a0)
                clr.w   4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                rts
; End of function Boss_InitDefeatExplosion
; Boss defeat sequence state dispatcher using jump table
Boss_DefeatStateDispatcher:                             ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_26928
                move.w  4(a5),d0
                movea.w Boss_DefeatStateOffsets(pc,d0.w),a0
                adda.l  #Boss_DefeatInitAnimation,a0
                jmp     (a0)
; End of function Boss_DefeatStateDispatcher
; ---------------------------------------------------------------------------
Boss_DefeatStateOffsets:    dc.w    Boss_DefeatInitAnimation-Boss_DefeatInitAnimation  ; was: off_26938
                                        ; DATA XREF: Boss_DefeatStateDispatcher+4   r
                dc.w    Boss_DefeatLoadGraphics-Boss_DefeatInitAnimation
                dc.w    Boss_DefeatSetupState-Boss_DefeatInitAnimation
                dc.w    Boss_DefeatScrollInit-Boss_DefeatInitAnimation
                dc.w    Boss_DefeatScrollUpdate-Boss_DefeatInitAnimation

; Initializes boss defeat animation state and graphics mode
Boss_DefeatInitAnimation:                               ; DATA XREF: Boss_DefeatStateDispatcher+8   o  ; was: sub_26942
                                        ; ROM:Boss_DefeatStateOffsets   o
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(byte_FFA95B).w
                clr.w   (word_FF808A).w
                bra.w   Effect_ClearTransitionPatternBuffer
; End of function Boss_DefeatInitAnimation
; Loads boss defeat explosion animation graphics via DMA
Boss_DefeatLoadGraphics:                                ; DATA XREF: ROM:0002693A   o  ; was: sub_2695C
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     Boss_DefeatGraphicsLoadDescriptor(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function Boss_DefeatLoadGraphics
; ---------------------------------------------------------------------------
Boss_DefeatGraphicsLoadDescriptor:  dc.w    7           ; field_0  ; was: stru_26976
                                        ; DATA XREF: Boss_DefeatLoadGraphics+8   o
                dc.l    byte_18D562                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF

; Sets up boss defeat state initializing scroll timers and playing sound
Boss_DefeatSetupState:                                  ; DATA XREF: ROM:0002693C   o  ; was: sub_26980
                addq.w  #2,4(a5)
                move.b  #3,(byte_FFA95B).w
                move.w  #$14,(word_FF8090).w
                move.w  #4,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                clr.w   (word_FF807C).w
                move.w  #8,(word_FF807A).w
                move.b  #$CA,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_DefeatSetupState
; Initializes boss defeat scroll animation with velocity parameters
Boss_DefeatScrollInit:                                  ; DATA XREF: ROM:0002693E   o  ; was: sub_269B4
                addq.w  #2,4(a5)
                move.l  #$18000,(dword_FF80A0).w
                bsr.w   Effect_InitDefeatScroll
; End of function Boss_DefeatScrollInit
; Updates boss defeat scroll position and checks for transition complete
Boss_DefeatScrollUpdate:                                ; DATA XREF: ROM:00026940   o  ; was: sub_269C4
                bsr.w   Effect_UpdateScrollPosition
                move.w  $10(a5),(dword_FF807E).w
                move.w  $14(a5),(dword_FF807E+2).w
                addq.w  #3,(word_FF807C).w
                cmpi.w  #$7F,(word_FF807C).w
                bmi.w   Effect_ApplyTransitionMask
                bra.w   Effect_UpdateTransition_Finish
; End of function Boss_DefeatScrollUpdate
; Initializes player spawn effect with position
Effect_InitPlayerSpawn:                                 ; CODE XREF: Boss_ShellshogunDefeatPaletteState+10   p  ; was: sub_269E6
                                        ; Boss_JokerFadeOutState+2E   p
                movea.w #(word_FFC680-M68K_RAM),a0
                move.w  #$150,(a0)
                clr.w   4(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                rts
; End of function Effect_InitPlayerSpawn
; Effect state machine dispatcher
Effect_TransitionObjectDispatcher:                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_26A00
                move.w  4(a5),d0
                movea.w Effect_TransitionObjectStateOffsets(pc,d0.w),a0
                adda.l  #Effect_TransitionInit,a0
                jmp     (a0)
; End of function Effect_TransitionObjectDispatcher
; ---------------------------------------------------------------------------
Effect_TransitionObjectStateOffsets:    dc.w    Effect_TransitionInit-Effect_TransitionInit  ; was: off_26A10
                                        ; DATA XREF: Effect_TransitionObjectDispatcher+4   r
                dc.w    Effect_LoadTransitionGraphics-Effect_TransitionInit
                dc.w    Effect_StartTransition-Effect_TransitionInit
                dc.w    Effect_SetupScroll-Effect_TransitionInit
                dc.w    Effect_UpdateTransition-Effect_TransitionInit

; Initializes screen transition effect state
Effect_TransitionInit:                                  ; DATA XREF: Effect_TransitionObjectDispatcher+8   o  ; was: sub_26A1A
                                        ; ROM:Effect_TransitionObjectStateOffsets   o
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(byte_FFA95B).w
                clr.w   (word_FF808A).w
                bra.w   Effect_ClearTransitionPatternBuffer
; End of function Effect_TransitionInit
; Loads transition graphics data
Effect_LoadTransitionGraphics:                          ; DATA XREF: ROM:00026A12   o  ; was: sub_26A34
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     Effect_TransitionGraphicsLoadDescriptor(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function Effect_LoadTransitionGraphics
; ---------------------------------------------------------------------------
Effect_TransitionGraphicsLoadDescriptor:    dc.w    7   ; field_0  ; was: stru_26A4E
                                        ; DATA XREF: Effect_LoadTransitionGraphics+8   o
                dc.l    byte_18D562                     ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF

; Starts screen transition with sound
Effect_StartTransition:                                 ; DATA XREF: ROM:00026A14   o  ; was: sub_26A58
                addq.w  #2,4(a5)
                move.b  #3,(byte_FFA95B).w
                move.w  #4,(word_FF8090).w
                move.w  #$10,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                clr.w   (word_FF807C).w
                move.b  #$CA,d0
                jsr     (Sound_PlaySFX).l
                move.w  #2,(word_FF807A).w
                rts
; End of function Effect_StartTransition
; Sets up scroll parameters for transition
Effect_SetupScroll:                                     ; DATA XREF: ROM:00026A16   o  ; was: sub_26A8E
                addq.w  #2,4(a5)
                move.l  #$18000,(dword_FF80A0).w
                bsr.w   Effect_BuildTransitionPattern
; End of function Effect_SetupScroll
; Updates transition effect with scroll and timer
Effect_UpdateTransition:                                ; DATA XREF: ROM:00026A18   o  ; was: sub_26A9E
                bsr.w   Effect_UpdateScrollPosition
                move.w  $10(a5),(dword_FF807E).w
                move.w  $14(a5),(dword_FF807E+2).w
                subi.l  #$3C0,(dword_FF80A0).w
                move.w  (FrameCounter).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                add.w   d0,(word_FF807C).w
                cmpi.w  #$7F,(word_FF807C).w
                bmi.w   Effect_ApplyTransitionMask
Effect_UpdateTransition_Finish:                         ; CODE XREF: Boss_DefeatScrollUpdate+1E   j  ; was: loc_26ACE
                clr.w   (word_FF807A).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (word_FF8090).w
                bset    #4,2(a5)
                move.b  #4,(byte_FFA95B).w
                bra.w   Effect_ClearTransitionPatternBuffer
; End of function Effect_UpdateTransition
; Dispatches to transition effect handler based on state index
Effect_TransitionDispatcher:                            ; CODE XREF: Credits_InitializeScreen+84   p  ; was: sub_26AEE
                move.w  (word_FF807A).w,d0
                movea.w Effect_TransitionModeOffsets(pc,d0.w),a0
                adda.l  #Effect_InitTransitionModeStandardA,a0
                jmp     (a0)
; End of function Effect_TransitionDispatcher
; ---------------------------------------------------------------------------
Effect_TransitionModeOffsets:   dc.w    Effect_InitTransitionModeStandardA-Effect_InitTransitionModeStandardA  ; was: off_26AFE
                                        ; DATA XREF: Effect_TransitionDispatcher+4   r
                dc.w    Effect_InitTransitionModeStandardB-Effect_InitTransitionModeStandardA
                dc.w    Effect_InitTransitionModeKeepProgress-Effect_InitTransitionModeStandardA
                dc.w    Effect_InitTransitionModeKeepProgress-Effect_InitTransitionModeStandardA
                dc.w    Effect_InitTransitionModeLong-Effect_InitTransitionModeStandardA

; Initializes transition effect with fade and palette settings
Effect_InitTransitionModeStandardA:                     ; DATA XREF: Effect_TransitionDispatcher+8   o  ; was: sub_26B08
                                        ; ROM:Effect_TransitionModeOffsets   o
                move.w  #4,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #$10,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                clr.w   (word_FF807C).w
                rts
; End of function Effect_InitTransitionModeStandardA
; Initializes the second standard transition mode
Effect_InitTransitionModeStandardB:                     ; DATA XREF: ROM:00026B00   o  ; was: sub_26B2A
                move.w  #4,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #$10,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                clr.w   (word_FF807C).w
                rts
; End of function Effect_InitTransitionModeStandardB
; Initializes transition with longer duration ($14 vs $4)
Effect_InitTransitionModeLong:                          ; DATA XREF: ROM:00026B06   o  ; was: sub_26B4C
                move.w  #$14,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #4,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                clr.w   (word_FF807C).w
                rts
; End of function Effect_InitTransitionModeLong
; Initializes transition effect without clearing progress counter
Effect_InitTransitionModeKeepProgress:                  ; DATA XREF: ROM:00026B02   o  ; was: sub_26B6E
                                        ; ROM:00026B04   o
                move.w  #4,(word_FF8090).w
                move.b  #$80,(byte_FFA95B).w
                move.w  #$10,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                rts
; End of function Effect_InitTransitionModeKeepProgress
; Palette effect dispatcher
Effect_PaletteDispatcher:                               ; CODE XREF: Cutscene_CreditsDispatcher   p  ; was: sub_26B8C
                                        ; Sys_GameplayMainLoop+118   p
                move.w  (word_FF807A).w,d0
                movea.w Effect_PaletteStateOffsets(pc,d0.w),a0
                adda.l  #Effect_PaletteUpdateMain,a0
                jmp     (a0)
; End of function Effect_PaletteDispatcher
; ---------------------------------------------------------------------------
Effect_PaletteStateOffsets: dc.w    Effect_PaletteEmptyState-Effect_PaletteUpdateMain  ; was: off_26B9C
                                        ; DATA XREF: Effect_PaletteDispatcher+4   r
                dc.w    Effect_PaletteUpdateMain-Effect_PaletteUpdateMain
                dc.w    Effect_InitializePaletteEffects-Effect_PaletteUpdateMain
                dc.w    Effect_InitPaletteEffect-Effect_PaletteUpdateMain
                dc.w    Effect_ComplexScrollWave-Effect_PaletteUpdateMain

; Main palette update routine
Effect_PaletteUpdateMain:                               ; DATA XREF: Effect_PaletteDispatcher+8   o  ; was: sub_26BA6
                                        ; ROM:Effect_PaletteStateOffsets   o
                bsr.w   Effect_InitPaletteBuffers
                bra.w   Effect_GenerateTransitionBuffers
; End of function Effect_PaletteUpdateMain
; Initializes palette buffers and applies two-stage effect setup
Effect_InitializePaletteEffects:                        ; DATA XREF: ROM:00026BA0   o  ; was: sub_26BAE
                bsr.w   Effect_InitPaletteBuffers
                bsr.w   Effect_InitScrollBuffers
                bsr.w   Effect_ProcessConditionalScroll
; End of function Effect_InitializePaletteEffects
Effect_PaletteEmptyState:                               ; DATA XREF: ROM:Effect_PaletteStateOffsets   o  ; was: nullsub_60
                rts
; End of function Effect_PaletteEmptyState

; Initializes palette effect by checking word_FF8082, clearing if negative, then calls buffer and effect setup routines
Effect_InitPaletteEffect:                               ; DATA XREF: ROM:00026BA2   o  ; was: sub_26BBC
                tst.w   (word_FF8082).w
                bpl.s   Effect_InitPaletteEffect_Setup
                clr.w   (word_FF8082).w
Effect_InitPaletteEffect_Setup:                         ; CODE XREF: Effect_InitPaletteEffect+4   j  ; was: loc_26BC6
                bsr.w   Effect_ClearScrollBuffer
                bsr.w   Effect_InitPaletteBuffers
                bsr.w   Effect_FillScrollBuffer
                bra.w   Effect_ProcessSimpleScroll
; End of function Effect_InitPaletteEffect
; Initializes scroll buffers at FF9480 using sine table data from Effect_TransitionSineTable, calculating 63 buffer values with interpolation
Effect_InitScrollBuffers:                               ; CODE XREF: Effect_InitializePaletteEffects+4   p  ; was: sub_26BD6
                movea.w #(word_FF9480-M68K_RAM),a0
                movea.w #(word_FF9480-M68K_RAM),a1
                moveq   #$3E,d7                         ; '>'
                movea.l #Effect_TransitionSineTable,a2
                move.w  (word_FF807C).w,d0
                andi.w  #$1FE,d0
                cmpi.w  #$80,d0
                beq.s   Effect_InitScrollBuffers_FillMaximum
                cmpi.w  #$180,d0
                beq.s   Effect_InitScrollBuffers_FillZero
                move.w  (a2,d0.w),d1
                muls.w  #$60,d1                         ; '`'
                asl.l   #2,d1
                move.l  #$300000,d0
Effect_InitScrollBuffers_FillLoop:                      ; CODE XREF: Effect_InitScrollBuffers+62   j  ; was: loc_26C0A
                tst.l   d0
                bpl.s   Effect_InitScrollBuffers_CheckHigh
Effect_InitScrollBuffers_ClampLow:                      ; CODE XREF: Effect_InitScrollBuffers+46   j  ; was: loc_26C0E
                clr.l   d0
                bra.s   Effect_InitScrollBuffers_StorePair
; ---------------------------------------------------------------------------
Effect_InitScrollBuffers_CheckHigh:                     ; CODE XREF: Effect_InitScrollBuffers+36   j  ; was: loc_26C12
                cmpi.l  #$600000,d0
                bpl.s   Effect_InitScrollBuffers_ClampHigh
                add.l   d1,d0
                bmi.s   Effect_InitScrollBuffers_ClampLow
                cmpi.l  #$600000,d0
                bmi.s   Effect_InitScrollBuffers_StorePair
Effect_InitScrollBuffers_ClampHigh:                     ; CODE XREF: Effect_InitScrollBuffers+42   j  ; was: loc_26C26
                move.l  #$600000,d0
Effect_InitScrollBuffers_StorePair:                     ; CODE XREF: Effect_InitScrollBuffers+3A   j  ; was: loc_26C2C
                                        ; Effect_InitScrollBuffers+4E   j
                swap    d0
                move.w  d0,(a0)+
                swap    d0
                swap    d0
                move.w  d0,-(a1)
                swap    d0
                dbf     d7,Effect_InitScrollBuffers_FillLoop
Effect_SetupScrollBufferPointers:                       ; CODE XREF: Effect_SetupScrollPointers   j  ; was: loc_26C3C
                movea.w #(dword_FF9400-M68K_RAM),a0
                movea.w #(word_FF9800-M68K_RAM),a2
                movea.w #(word_FF9600-M68K_RAM),a3
                rts
; ---------------------------------------------------------------------------
Effect_InitScrollBuffers_FillMaximum:                   ; CODE XREF: Effect_InitScrollBuffers+1C   j  ; was: loc_26C4A
                moveq   #$60,d0                         ; '`'
                bra.s   Effect_InitScrollBuffers_FillConstantLoop
; ---------------------------------------------------------------------------
Effect_InitScrollBuffers_FillZero:                      ; CODE XREF: Effect_InitScrollBuffers+22   j  ; was: loc_26C4E
                moveq   #0,d0
Effect_InitScrollBuffers_FillConstantLoop:              ; CODE XREF: Effect_InitScrollBuffers+76   j  ; was: loc_26C50
                                        ; Effect_InitScrollBuffers+7E   j
                move.w  d0,(a0)+
                move.w  d0,-(a1)
                dbf     d7,Effect_InitScrollBuffers_FillConstantLoop
; End of function Effect_InitScrollBuffers
; Attributes: thunk
; Thunk to set up scroll effect address registers a0/a2/a3 to point to scroll data buffers
