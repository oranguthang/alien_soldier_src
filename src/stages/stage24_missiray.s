Stage24_Init:                                           ; DATA XREF: ROM:0000F13C   o  ; was: sub_F7FA
                addq.w  #2,(word_FFA950).w
                move.l  #$FFFE0000,(dword_FFA960).w
                move.b  #4,(word_FFF7E6+1).w
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
; Stage 24 initialization loop with graphics and timer
Stage24_InitLoop:                                       ; DATA XREF: ROM:0000F13E   o  ; was: loc_F89C
                bsr.w   Stage24_GraphicsSetup
                subq.w  #1,(word_FF9DB0).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                move.w  #$80,(word_FF9DB0).w
                jmp     Stage_TransitionToNextPhase
; End of function Stage24_Init
; Transition to boss
Boss_MissirayTransition:                                ; DATA XREF: ROM:0000F140   o  ; was: sub_F8B4
                bsr.w   Stage24_GraphicsSetup
                subq.w  #1,(word_FF9DB0).w
                bpl.w   Boss_DestroyerProtoTransition_Return
                addq.w  #2,(word_FFA950).w
                lea     (Boss_MissirayAssetSet).l,a1
                jmp     Boss_LoadAssetSet
; End of function Boss_MissirayTransition
; Boss initialization
Boss_MissirayInit:                                      ; DATA XREF: ROM:0000F142   o  ; was: sub_F8D0
                tst.w   (Entity_ObjectPool).w
                bne.s   loc_F8E6
                addq.w  #2,(word_FFA950).w
                move.w  #$2E,(MessageSequenceState).w   ; '.'
                move.b  #1,(byte_FF830E).w
loc_F8E6:                                               ; CODE XREF: Boss_MissirayInit+4   j
                bra.w   Stage24_GraphicsSetup
; End of function Boss_MissirayInit
; Palette update handler
Boss_MissirayPaletteUpdate:                             ; DATA XREF: ROM:0000F144   o  ; was: sub_F8EA
                bsr.w   Stage24_GraphicsSetup
                tst.w   (MessageSequenceState).w
                bne.s   locret_F912
                tst.w   (word_FF8230).w
                bne.s   locret_F912
                tst.w   (word_FF8138).w
                bne.s   locret_F912
                move.b  #$9F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_F912:                                            ; CODE XREF: Boss_MissirayPaletteUpdate+8   j
                                        ; Boss_MissirayPaletteUpdate+E   j
                rts
; End of function Boss_MissirayPaletteUpdate
; Graphics setup
Stage24_GraphicsSetup:                                  ; CODE XREF: Stage24_Init:loc_F89C   p  ; was: sub_F914
                                        ; sub_F8B4   p
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
loc_F946:                                               ; CODE XREF: Stage24_GraphicsSetup+36   j
                move.w  d2,(a0)
                addq.w  #4,a0
                dbf     d7,loc_F946
                rts
; End of function Stage24_GraphicsSetup
; Scroll handler
Stage24_ScrollHandler:                                  ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_F950
                move.b  (byte_FFA420).w,$20(a5)
                subq.b  #4,$20(a5)
                tst.w   $56(a5)
                bne.s   locret_F9B4
                bclr    #0,6(a5)
                beq.s   loc_F9AA
                tst.w   (ShootingMode).w
                beq.s   loc_F976
                btst    #2,(byte_FF8244).w
                bne.s   loc_F9AA
loc_F976:                                               ; CODE XREF: Stage24_ScrollHandler+1C   j
                btst    #0,(word_FFF706).w
                beq.s   loc_F990
                subq.w  #1,$14(a5)
                cmpi.w  #$D0,$14(a5)
                bpl.s   loc_F9AA
                move.w  #$D0,$14(a5)
loc_F990:                                               ; CODE XREF: Stage24_ScrollHandler+2C   j
                btst    #1,(word_FFF706).w
                beq.s   loc_F9AA
                addq.w  #1,$14(a5)
                cmpi.w  #$160,$14(a5)
                bmi.s   loc_F9AA
                move.w  #$160,$14(a5)
loc_F9AA:                                               ; CODE XREF: Stage24_ScrollHandler+16   j
                                        ; Stage24_ScrollHandler+24   j
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  $14(a5),$14(a0)
locret_F9B4:                                            ; CODE XREF: Stage24_ScrollHandler+E   j
                rts
; End of function Stage24_ScrollHandler
; Initializes stage 24 cutscene objects and sound
Stage24_InitCutscene:                                   ; DATA XREF: ROM:0000F14A   o  ; was: sub_F9B6
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
; End of function Stage24_InitCutscene
; Accelerates vertical scroll until target reached
Camera_ScrollAccelerate:                                ; DATA XREF: ROM:0000F14C   o  ; was: sub_FA0E
                cmpi.w  #2,(dword_FF8066+2).w
                bpl.s   loc_FA1E
                addi.l  #$1000,(dword_FF8066+2).w
loc_FA1E:                                               ; CODE XREF: Camera_ScrollAccelerate+6   j
                move.l  (dword_FF8066+2).w,d0
                add.l   d0,(dword_FFA900).w
                cmpi.w  #$C0,(dword_FFA900).w
                bmi.s   locret_FA38
                addq.w  #2,(word_FFA950).w
                move.w  #$C0,(dword_FFA900).w
locret_FA38:                                            ; CODE XREF: Camera_ScrollAccelerate+1E   j
                rts
; End of function Camera_ScrollAccelerate
; Clamps vertical scroll position to bounds
Scroll_ClampVerticalPos:                                ; DATA XREF: ROM:0000F14E   o  ; was: sub_FA3A
                move.w  #$100,d0
                sub.w   (dword_FFDB34).w,d0
                bmi.s   loc_FA46
                moveq   #0,d0
loc_FA46:                                               ; CODE XREF: Scroll_ClampVerticalPos+8   j
                cmpi.w  #$FFE0,d0
                bpl.s   loc_FA54
                addq.w  #2,(word_FFA950).w
                move.w  #$FFE0,d0
loc_FA54:                                               ; CODE XREF: Scroll_ClampVerticalPos+10   j
                move.w  d0,(dword_FFA904).w
                rts
; End of function Scroll_ClampVerticalPos
; Checks if stage phase complete and transitions
Stage_CheckPhaseComplete:                               ; DATA XREF: ROM:0000F150   o  ; was: sub_FA5A
                tst.b   (byte_FFA958).w
                beq.s   locret_FA82
                tst.w   (word_FF8230).w
                bne.s   locret_FA82
                tst.w   (word_FF8138).w
                bne.s   locret_FA82
                addq.w  #2,(StageTableIndex).w
                move.b  #$8F,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_FA82:                                            ; CODE XREF: Stage_CheckPhaseComplete+4   j
                                        ; Stage_CheckPhaseComplete+A   j
                rts
; End of function Stage_CheckPhaseComplete
; Increments stage phase counter
Stage_IncrementPhase:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_FA84
                                        ; ROM:0000F15E   o
                addq.w  #2,(word_FFA950).w
; Return after incrementing stage phase
Stage_IncrementPhase_Return:                            ; DATA XREF: ROM:0000F160   o  ; was: locret_FA88
                rts
; End of function Stage_IncrementPhase
; Stage transition init
