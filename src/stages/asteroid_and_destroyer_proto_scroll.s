StageTransition_RenderAsteroidField:                    ; CODE XREF: StageTransition_StartAsteroidFieldScroll+26   j  ; was: sub_FB24
                                        ; StageTransition_FinishAsteroidFieldScroll+E   j
                bsr.s   StageTransition_UpdateAsteroidFieldScroll
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                bra.w   loc_109E0
; End of function StageTransition_RenderAsteroidField
; Advances both asteroid-field positions and detects a $100 boundary crossing
StageTransition_UpdateAsteroidFieldScroll:              ; CODE XREF: StageTransition_InitializeAsteroidField+70   j  ; was: sub_FB3A
                                        ; StageTransition_StartAsteroidFieldScroll+C   j
                move.l  (dword_FFA960).w,d0
                add.l   d0,(dword_FFA904).w
                add.l   d0,(dword_FFA964).w
                clr.b   (byte_FFA96A).w
                move.w  (dword_FFA964).w,d0
                andi.w  #$100,d0
                cmp.w   (word_FFA968).w,d0
                beq.s   StageTransition_SharedReturn
                addq.b  #1,(byte_FFA96A).w
                move.w  d0,(word_FFA968).w
; Shared return for inactive or incomplete transition states
StageTransition_SharedReturn:                           ; CODE XREF: StageTransition_LoadDestroyerProtoAssets+8   j  ; was: locret_FB60
                                        ; StageTransition_InitializeDestroyerProtoBackdrop+8   j
                rts
; End of function StageTransition_UpdateAsteroidFieldScroll
; Unreferenced input-bit test that sets the transition completion flag
UnreferencedSetTransitionFlagFromInputBit6:
                btst    #6,(word_FFF706).w              ; was: sub_FB62
                beq.s   UnreferencedTransitionInputCheckReturn
                bset    #0,(byte_FFA958).w
UnreferencedTransitionInputCheckReturn:                 ; CODE XREF: UnreferencedSetTransitionFlagFromInputBit6+6   j  ; was: locret_FB70
                rts
; End of function UnreferencedSetTransitionFlagFromInputBit6
; Integrates asteroid-field velocity and fills its vertical-scroll buffer
StageTransition_FillAsteroidFieldVScroll:               ; CODE XREF: StageTransition_InitializeAsteroidField:StageTransition_UpdateAsteroidFieldEntry   p  ; was: sub_FB72
                                        ; StageTransition_StartAsteroidFieldScroll   p
                move.l  (dword_FF8066).w,d0
                add.l   (dword_FF8062).w,d0
                move.l  d0,(dword_FF8066).w
                swap    d0
                movea.w #(word_FFE480-M68K_RAM),a0
                move.w  #$BF,d7
StageTransition_FillAsteroidFieldVScrollLoop:           ; CODE XREF: StageTransition_FillAsteroidFieldVScroll+1A   j  ; was: loc_FB88
                move.w  d0,(a0)
                addq.w  #4,a0
                dbf     d7,StageTransition_FillAsteroidFieldVScrollLoop
                rts
; End of function StageTransition_FillAsteroidFieldVScroll
; Unreferenced entry that updates and shifts the segmented V-scroll buffer
UnreferencedUpdateAndShiftTransitionVScroll:
                bsr.w   StageTransition_UpdateSegmentedBackdropScroll  ; was: sub_FB92
                movea.w #(word_FFE480-M68K_RAM),a0
                moveq   #$5F,d7                         ; '_'
UnreferencedShiftTransitionVScrollLoop:                 ; CODE XREF: UnreferencedUpdateAndShiftTransitionVScroll+10   j  ; was: loc_FB9C
                move.w  2(a0),(a0)
                addq.w  #4,a0
                dbf     d7,UnreferencedShiftTransitionVScrollLoop
                rts
; End of function UnreferencedUpdateAndShiftTransitionVScroll
; Updates the segmented transition backdrop's motion and V-scroll pattern
StageTransition_UpdateSegmentedBackdropScroll:          ; CODE XREF: StageTransition_InitializeAsteroidField+56   p  ; was: sub_FBA8
                                        ; StageTransition_StartAsteroidFieldScroll+4   p
                tst.w   (dword_FF9DA2).w
                bpl.s   StageTransition_DampenFirstBackdropVelocity
                cmpi.l  #$FFFF8080,(dword_FF9DA2).w
                bmi.s   StageTransition_CheckSecondBackdropVelocity
StageTransition_DampenFirstBackdropVelocity:            ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+4   j  ; was: loc_FBB8
                subi.l  #$40,(dword_FF9DA2).w           ; '@'
StageTransition_CheckSecondBackdropVelocity:            ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+E   j  ; was: loc_FBC0
                tst.w   (dword_FF9D9E).w
                bpl.s   StageTransition_DampenSecondBackdropVelocity
                cmpi.l  #$FFFF8000,(dword_FF9D9E).w
                bmi.s   StageTransition_ApplySegmentedBackdropMotion
StageTransition_DampenSecondBackdropVelocity:           ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+1C   j  ; was: loc_FBD0
                subi.l  #$40,(dword_FF9D9E).w           ; '@'
StageTransition_ApplySegmentedBackdropMotion:           ; CODE XREF: StageTransition_UpdateDestroyerProtoBackdropFade+C   p  ; was: loc_FBD8
                                        ; StageTransition_UpdatePostDestroyerProtoScroll+4   p
                move.l  (dword_FF9DA2).w,d0
                add.l   d0,(dword_FF9DAA).w
                add.l   d0,(dword_FF9DB2).w
                move.l  (dword_FF9DA6).w,d0
                add.l   (dword_FF9D9E).w,d0
                move.l  d0,(dword_FF9DA6).w
                swap    d0
                move.w  d0,d1
                move.w  d0,d2
                move.w  d0,d3
                move.w  d0,d4
                move.w  d0,d5
                move.w  d0,d6
                asr.w   #1,d1
                asr.w   #2,d2
                asr.w   #3,d3
                asr.w   #4,d4
                asr.w   #5,d5
                asr.w   #6,d6
                movea.w #(byte_FF9D80-M68K_RAM),a0
                moveq   #1,d7
StageTransition_BuildBackdropScrollPattern:             ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+70   j  ; was: loc_FC10
                move.w  d0,(a0)+
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                move.w  d3,(a0)+
                dbf     d7,StageTransition_BuildBackdropScrollPattern
                move.w  (word_FFEC02).w,d7
                andi.w  #3,d7
                asl.w   #1,d7
                movea.w #(byte_FF9D80-M68K_RAM),a0
                adda.w  d7,a0
                move.w  (a0)+,d0
                move.w  (a0)+,d1
                move.w  (a0)+,d2
                move.w  (a0)+,d3
                btst    #0,(FrameCounter+1).w
                beq.s   StageTransition_CheckBackdropScrollParity
                asr.w   #1,d0
                asr.w   #1,d1
                asr.w   #1,d2
                asr.w   #1,d3
StageTransition_CheckBackdropScrollParity:              ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+92   j  ; was: loc_FC44
                movea.w #(byte_FFE482-M68K_RAM),a0
                move.w  #$2F,d7                         ; '/'
StageTransition_FillSegmentedBackdropVScroll:           ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+B4   j  ; was: loc_FC4C
                move.w  d0,(a0)
                addq.w  #4,a0
                move.w  d1,(a0)
                addq.w  #4,a0
                move.w  d2,(a0)
                addq.w  #4,a0
                move.w  d3,(a0)
                addq.w  #4,a0
                dbf     d7,StageTransition_FillSegmentedBackdropVScroll
                move.l  (dword_FF9DB2).w,d0
                btst    #0,(FrameCounter+1).w
                bne.s   StageTransition_StoreSegmentedBackdropOutput
                asr.l   #1,d0
StageTransition_StoreSegmentedBackdropOutput:           ; CODE XREF: StageTransition_UpdateSegmentedBackdropScroll+C2   j  ; was: loc_FC6E
                move.l  d0,(dword_FFA90C).w
                rts
; End of function StageTransition_UpdateSegmentedBackdropScroll
