StageTransition_InitializeMissirayEntryScene:           ; DATA XREF: ROM:0000F13C   o  ; was: sub_F7FA
                addq.w  #2,(word_FFA950).w
                move.l  #$FFFE0000,(dword_FFA960).w
                move.b  #4,(VDPReg11Shadow+1).w
                move.b  #2,(byte_FFA95A).w
                move.b  #8,(byte_FFA95B).w
                move.w  #$200,(word_FF9DB0).w
                movea.w #(word_FFDB20-M68K_RAM),a0
                movea.w #(byte_FFDB80-M68K_RAM),a1
                move.w  #$3E0,(a0)
                move.w  #$C400,2(a0)
                move.l  #word_1CF762,8(a0)
                move.w  #$8200,$E(a0)
                move.b  #$20,$21(a0)                    ; ' '
                move.w  #2,$46(a0)
                move.l  #$FF000100,$28(a0)
                move.w  #$150,d6
                move.w  #$120,d7
                move.w  d6,$10(a0)
                move.w  d7,$14(a0)
                move.w  d6,$4C(a0)
                move.w  d7,$4E(a0)
                clr.w   $56(a0)
                move.w  #$3E0,(a1)
                move.w  #1,$56(a1)
                move.w  #$C400,2(a1)
                move.l  #word_1CF780,8(a1)
                move.w  #$8200,$E(a1)
                move.w  #$D0,$10(a1)
                move.w  d7,$14(a1)
                move.w  #$3C8,(word_FFDBE0).w
; Updates the Missiray entry parallax until the scene delay expires
StageTransition_UpdateMissirayEntryDelay:               ; DATA XREF: ROM:0000F13E   o  ; was: loc_F89C
                bsr.w   StageTransition_UpdateMissirayParallax
                subq.w  #1,(word_FF9DB0).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                move.w  #$80,(word_FF9DB0).w
                jmp     Stage_TransitionToNextPhase
; End of function StageTransition_InitializeMissirayEntryScene
; Waits for the entry delay, then starts loading the Missiray asset set
StageTransition_LoadMissirayAssets:                     ; DATA XREF: ROM:0000F140   o  ; was: sub_F8B4
                bsr.w   StageTransition_UpdateMissirayParallax
                subq.w  #1,(word_FF9DB0).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                lea     (Boss_MissirayAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function StageTransition_LoadMissirayAssets
; Waits for the first object slot to clear before starting the Missiray message
StageTransition_WaitForMissirayObjectClear:             ; DATA XREF: ROM:0000F142   o  ; was: sub_F8D0
                tst.w   (Entity_ObjectPool).w
                bne.s   StageTransition_UpdateMissirayEntryScene
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                move.b  #1,(byte_FF830E).w
StageTransition_UpdateMissirayEntryScene:               ; CODE XREF: StageTransition_WaitForMissirayObjectClear+4   j  ; was: loc_F8E6
                bra.w   StageTransition_UpdateMissirayParallax
; End of function StageTransition_WaitForMissirayObjectClear
; Waits for the Missiray message and shared activity signals before leaving the scene
StageTransition_WaitForMissirayExitSignals:             ; DATA XREF: ROM:0000F144   o  ; was: sub_F8EA
                bsr.w   StageTransition_UpdateMissirayParallax
                tst.w   (MessageSequenceState).w
                bne.s   StageTransition_MissirayExitWaitReturn
                tst.w   (word_FF8230).w
                bne.s   StageTransition_MissirayExitWaitReturn
                tst.w   (word_FF8138).w
                bne.s   StageTransition_MissirayExitWaitReturn
                move.b  #$9F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; ---------------------------------------------------------------------------
StageTransition_MissirayExitWaitReturn:                 ; CODE XREF: StageTransition_WaitForMissirayExitSignals+8   j  ; was: locret_F912
                                        ; StageTransition_WaitForMissirayExitSignals+E   j
                rts
; End of function StageTransition_WaitForMissirayExitSignals
; Applies the Missiray scene's full-, half-, and quarter-speed vertical parallax
StageTransition_UpdateMissirayParallax:                 ; CODE XREF: StageTransition_InitializeMissirayEntryScene:StageTransition_UpdateMissirayEntryDelay   p  ; was: sub_F914
                                        ; StageTransition_LoadMissirayAssets   p
                move.l  (dword_FFA960).w,d0
                sub.l   d0,(dword_FFA904).w
                move.w  (dword_FFA904).w,d0
                move.w  d0,d1
                move.w  d0,d2
                asr.w   #1,d1
                asr.w   #2,d2
                move.w  d0,(VScrollBuffer).w
                move.w  d0,(word_FFEC04).w
                move.w  d0,(word_FFEC48).w
                move.w  d0,(word_FFEC4C).w
                move.w  d1,(word_FFEC08).w
                move.w  d1,(word_FFEC44).w
                movea.w #(word_FFEC0C-M68K_RAM),a0
                moveq   #$D,d7
StageTransition_FillMissirayQuarterSpeedVScroll:        ; CODE XREF: StageTransition_UpdateMissirayParallax+36   j  ; was: loc_F946
                move.w  d2,(a0)
                addq.w  #4,a0
                dbf     d7,StageTransition_FillMissirayQuarterSpeedVScroll
                rts
; End of function StageTransition_UpdateMissirayParallax
; Updates either member of the linked Missiray scene-object pair
StageTransition_UpdateMissiraySceneObject:              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_F950
                move.b  (byte_FFA420).w,$20(a5)
                subq.b  #4,$20(a5)
                tst.w   $56(a5)
                bne.s   StageTransition_MissiraySceneObjectReturn
                bclr    #0,6(a5)
                beq.s   StageTransition_SyncMissiraySceneObjectHeight
                tst.w   (ShootingMode).w
                beq.s   StageTransition_CheckMissiraySceneUpInput
                btst    #2,(byte_FF8244).w
                bne.s   StageTransition_SyncMissiraySceneObjectHeight
StageTransition_CheckMissiraySceneUpInput:              ; CODE XREF: StageTransition_UpdateMissiraySceneObject+1C   j  ; was: loc_F976
                btst    #0,(word_FFF706).w
                beq.s   StageTransition_CheckMissiraySceneDownInput
                subq.w  #1,$14(a5)
                cmpi.w  #$D0,$14(a5)
                bpl.s   StageTransition_SyncMissiraySceneObjectHeight
                move.w  #$D0,$14(a5)
StageTransition_CheckMissiraySceneDownInput:            ; CODE XREF: StageTransition_UpdateMissiraySceneObject+2C   j  ; was: loc_F990
                btst    #1,(word_FFF706).w
                beq.s   StageTransition_SyncMissiraySceneObjectHeight
                addq.w  #1,$14(a5)
                cmpi.w  #$160,$14(a5)
                bmi.s   StageTransition_SyncMissiraySceneObjectHeight
                move.w  #$160,$14(a5)
StageTransition_SyncMissiraySceneObjectHeight:          ; CODE XREF: StageTransition_UpdateMissiraySceneObject+16   j  ; was: loc_F9AA
                                        ; StageTransition_UpdateMissiraySceneObject+24   j
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  $14(a5),$14(a0)
StageTransition_MissiraySceneObjectReturn:              ; CODE XREF: StageTransition_UpdateMissiraySceneObject+E   j  ; was: locret_F9B4
                rts
; End of function StageTransition_UpdateMissiraySceneObject
; Initializes the Stage 24 scene objects, vertical range, and sound
StageTransition_InitializeStage24SceneObjects:          ; DATA XREF: ROM:0000F14A   o  ; was: sub_F9B6
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$410,(a0)
                move.w  #$256,$10(a0)
                move.w  #$60,$14(a0)                    ; '`'
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  #$10,(a0)
                move.w  #$C500,2(a0)
                move.w  #$AC0,$E(a0)
                move.b  #$10,$20(a0)
                move.l  #word_1CE4F8,8(a0)
                move.w  #0,(word_FFA970).w
                move.w  #$C0,(word_FFA974).w
                clr.l   (dword_FF8066+2).w
                move.b  #$C9,d0
                jsr     (Sound_PlaySFX).l
; End of function StageTransition_InitializeStage24SceneObjects
; Accelerates the Stage 24 vertical scroll until coordinate $C0
StageTransition_AccelerateStage24VerticalScroll:        ; DATA XREF: ROM:0000F14C   o  ; was: sub_FA0E
                cmpi.w  #2,(dword_FF8066+2).w
                bpl.s   StageTransition_ApplyStage24VerticalScroll
                addi.l  #$1000,(dword_FF8066+2).w
StageTransition_ApplyStage24VerticalScroll:             ; CODE XREF: StageTransition_AccelerateStage24VerticalScroll+6   j  ; was: loc_FA1E
                move.l  (dword_FF8066+2).w,d0
                add.l   d0,(dword_FFA900).w
                cmpi.w  #$C0,(dword_FFA900).w
                bmi.s   StageTransition_Stage24VerticalScrollReturn
                addq.w  #2,(word_FFA950).w
                move.w  #$C0,(dword_FFA900).w
StageTransition_Stage24VerticalScrollReturn:            ; CODE XREF: StageTransition_AccelerateStage24VerticalScroll+1E   j  ; was: locret_FA38
                rts
; End of function StageTransition_AccelerateStage24VerticalScroll
; Derives and clamps the Stage 24 vertical offset from the first scene object
StageTransition_UpdateStage24VerticalOffset:            ; DATA XREF: ROM:0000F14E   o  ; was: sub_FA3A
                move.w  #$100,d0
                sub.w   (dword_FFDB34).w,d0
                bmi.s   StageTransition_CheckStage24VerticalOffsetLimit
                moveq   #0,d0
StageTransition_CheckStage24VerticalOffsetLimit:        ; CODE XREF: StageTransition_UpdateStage24VerticalOffset+8   j  ; was: loc_FA46
                cmpi.w  #$FFE0,d0
                bpl.s   StageTransition_StoreStage24VerticalOffset
                addq.w  #2,(word_FFA950).w
                move.w  #$FFE0,d0
StageTransition_StoreStage24VerticalOffset:             ; CODE XREF: StageTransition_UpdateStage24VerticalOffset+10   j  ; was: loc_FA54
                move.w  d0,(dword_FFA904).w
                rts
; End of function StageTransition_UpdateStage24VerticalOffset
; Waits for Stage 24 completion and shared activity signals before advancing
StageTransition_WaitForStage24CompletionSignals:        ; DATA XREF: ROM:0000F150   o  ; was: sub_FA5A
                tst.b   (byte_FFA958).w
                beq.s   StageTransition_Stage24CompletionWaitReturn
                tst.w   (word_FF8230).w
                bne.s   StageTransition_Stage24CompletionWaitReturn
                tst.w   (word_FF8138).w
                bne.s   StageTransition_Stage24CompletionWaitReturn
                addq.w  #2,(StageTableIndex).w
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; ---------------------------------------------------------------------------
StageTransition_Stage24CompletionWaitReturn:            ; CODE XREF: StageTransition_WaitForStage24CompletionSignals+4   j  ; was: locret_FA82
                                        ; StageTransition_WaitForStage24CompletionSignals+A   j
                rts
; End of function StageTransition_WaitForStage24CompletionSignals
; Advances the global transition state when invoked by its controller object
StageTransition_AdvanceStateFromObject:                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_FA84
                                        ; ROM:0000F15E   o
                addq.w  #2,(word_FFA950).w
; Shared inert transition state and return after advancing the state
StageTransition_StateAdvanceReturn:                     ; DATA XREF: ROM:0000F160   o  ; was: locret_FA88
                rts
; End of function StageTransition_AdvanceStateFromObject
