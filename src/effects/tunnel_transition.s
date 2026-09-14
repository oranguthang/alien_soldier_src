; Dispatches the tunnel transition object's five states
TunnelTransition_ObjectMain:                            ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_27934
                move.w  4(a5),d0
                movea.w TunnelTransition_StateOffsets(pc,d0.w),a0
                adda.l  #TunnelTransition_InitializeObject,a0
                jmp     (a0)
; ---------------------------------------------------------------------------
TunnelTransition_StateOffsets:  dc.w    TunnelTransition_InitializeObject-TunnelTransition_InitializeObject  ; was: off_27944
                                        ; DATA XREF: TunnelTransition_ObjectMain+4   r
                dc.w    TunnelTransition_LoadGraphics-TunnelTransition_InitializeObject
                dc.w    TunnelTransition_ConfigureEffect-TunnelTransition_InitializeObject
                dc.w    TunnelTransition_BuildInitialPattern-TunnelTransition_InitializeObject
                dc.w    TunnelTransition_Update-TunnelTransition_InitializeObject
; End of function TunnelTransition_ObjectMain
; Initializes the object and clears its transition-mask buffer
TunnelTransition_InitializeObject:                      ; DATA XREF: TunnelTransition_ObjectMain+8   o  ; was: sub_2794E
                                        ; TunnelTransition_ObjectMain:TunnelTransition_StateOffsets   o
                move.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.b  #4,(PlaneBScrollModeFlags).w
                clr.w   (GlobalSpritePriorityBit).w
                bra.w   Effect_ClearTransitionPatternBuffer
; End of function TunnelTransition_InitializeObject
; Loads the shared transition graphics
TunnelTransition_LoadGraphics:                          ; DATA XREF: TunnelTransition_ObjectMain+12   o  ; was: sub_27968
                addq.w  #2,4(a5)
                movem.l a5,-(sp)
                lea     TunnelTransition_GraphicsLoadDescriptor(pc),a0
                nop
                jsr     (LoadObjData).l
                movem.l (sp)+,a5
                rts
; End of function TunnelTransition_LoadGraphics
; ---------------------------------------------------------------------------
TunnelTransition_GraphicsLoadDescriptor:    dc.w    7   ; field_0  ; was: stru_27982
                                        ; DATA XREF: TunnelTransition_LoadGraphics+8   o
                dc.l    CreditsAndTransitionTileArtE000  ; field_2
                dc.w    $E000                           ; field_6
                dc.w    $FFFF

; Configures the tunnel transition's raster and buffer modes
TunnelTransition_ConfigureEffect:                       ; DATA XREF: TunnelTransition_ObjectMain+14   o  ; was: sub_2798C
                addq.w  #2,4(a5)
                move.b  #3,(PlaneBScrollModeFlags).w
                move.w  #4,(RasterLayoutOffset).w
                move.w  #$10,(RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                move.b  #3,(VDPReg11Shadow+1).w
                clr.w   (TransitionProgress).w
                move.b  #$AA,d0
                jsr     (Sound_QueueSFXRequest).l
                move.w  #2,(TransitionModeOffset).w
                rts
; End of function TunnelTransition_ConfigureEffect
; Builds the tunnel transition's initial mask pattern
TunnelTransition_BuildInitialPattern:                   ; DATA XREF: TunnelTransition_ObjectMain+16   o  ; was: sub_279C2
                addq.w  #2,4(a5)
                move.l  #$18000,(TransitionEdgeSpan).w
                bsr.w   Effect_BuildTransitionPattern
; End of function TunnelTransition_BuildInitialPattern
; Advances the tunnel transition and delays mask growth until progress $4E
TunnelTransition_Update:                                ; DATA XREF: TunnelTransition_ObjectMain+18   o  ; was: sub_279D2
                bsr.w   Effect_UpdateScrollPosition
                move.w  $10(a5),(TransitionOriginXY).w
                move.w  $14(a5),(TransitionOriginXY+2).w
                move.w  (FrameCounter).w,d0
                andi.w  #1,d0
                addq.w  #1,d0
                add.w   d0,(TransitionProgress).w
                cmpi.w  #$7F,(TransitionProgress).w
                bmi.s   TunnelTransition_UpdateMask
                clr.w   (TransitionModeOffset).w
                clr.w   (RasterEffectIndex).w
                clr.w   (RasterEffectInitState).w
                clr.w   (RasterLayoutOffset).w
                bset    #4,2(a5)
                move.b  #4,(PlaneBScrollModeFlags).w
                bra.w   Effect_ClearTransitionPatternBuffer
; ---------------------------------------------------------------------------
TunnelTransition_Return:                                ; CODE XREF: TunnelTransition_UpdateMask+8   j  ; was: locret_27A18
                rts
; ---------------------------------------------------------------------------
TunnelTransition_UpdateMask:                            ; CODE XREF: TunnelTransition_Update+24   j  ; was: loc_27A1A
                move.w  (TransitionProgress).w,d0
                subi.w  #$4E,d0                         ; 'N'
                bmi.s   TunnelTransition_Return
                asr.w   #4,d0
                move.w  d0,(TransitionMaskStep).w
                bra.w   Effect_ApplyTransitionMask
; End of function TunnelTransition_Update
