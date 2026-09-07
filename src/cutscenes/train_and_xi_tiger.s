Entity_TrainEndDispatcher:                              ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2EF32
                clr.w   6(a5)
                move.w  4(a5),d0
                lea     off_2EF42(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Entity_TrainEndDispatcher
; ---------------------------------------------------------------------------
off_2EF42:      dc.w    Entity_TrainEndInit-*           ; DATA XREF: Entity_TrainEndDispatcher+8   o
                dc.w    Entity_TransitionAnimationState-*
                dc.w    Entity_TrainJumpPrep-*
                dc.w    Entity_TrainJumpWait-*
                dc.w    Entity_TrainJumpFall-*
                dc.w    Entity_TrainJumpComplete-*

; Initializes train end entity with animation and position
Entity_TrainEndInit:                                    ; DATA XREF: ROM:off_2EF42   o  ; was: sub_2EF4E
                addq.w  #2,4(a5)
                move.w  #$80,$48(a5)
                bsr.w   Entity_TrainEndLoadPalette
                bset    #3,$E(a5)
                move.w  #$100,$10(a5)
                move.w  (dword_FFA904).w,d0
                bsr.w   Entity_TrainUpdateYPosition
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                rts
; End of function Entity_TrainEndInit
; Loads palette and sprite parameters for train end
Entity_TrainEndLoadPalette:                             ; CODE XREF: Entity_TrainEndInit+A   p  ; was: sub_2EF7E
                                        ; Entity_XiTigerIntroDispatcher+4   p
                lea     (byte_C1C2).l,a0
                jsr     (LoadPalette).l
                move.w  #$CD00,2(a5)
                move.w  #$E400,$E(a5)
                move.l  #$F010F808,$2C(a5)
                move.l  #$F010F808,$28(a5)
                move.b  #$C0,$21(a5)
                move.b  #$10,$23(a5)
                move.b  #$60,$20(a5)                    ; '`'
                rts
; End of function Entity_TrainEndLoadPalette
; Updates entity Y position based on train scroll
Entity_TrainUpdateYPosition:                            ; CODE XREF: Entity_TrainEndInit+1E   p  ; was: sub_2EFBA
                                        ; sub_2EFC8   p
                move.w  (dword_FFA904).w,$14(a5)
                addi.w  #$A8,$14(a5)
                rts
; End of function Entity_TrainUpdateYPosition
; Transitions entity animation state with frame update
Entity_TransitionAnimationState:                        ; DATA XREF: ROM:0002EF44   o  ; was: sub_2EFC8
                bsr.w   Entity_TrainUpdateYPosition
                subq.w  #1,$48(a5)
                bne.s   locret_2EFE8
                move.l  #word_EBD5C,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
locret_2EFE8:                                           ; CODE XREF: Entity_TransitionAnimationState+8   j
                rts
; End of function Entity_TransitionAnimationState
; Prepares entity for train jump with animation setup
Entity_TrainJumpPrep:                                   ; DATA XREF: ROM:0002EF46   o  ; was: sub_2EFEA
                bsr.w   Entity_TrainUpdateYPosition
                subq.w  #1,$48(a5)
                bne.s   locret_2F018
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                move.l  #$FFFA0000,$1C(a5)
                move.w  #$FFFC,$18(a5)
                move.w  #4,$48(a5)
                addq.w  #2,4(a5)
locret_2F018:                                           ; CODE XREF: Entity_TrainJumpPrep+8   j
                rts
; End of function Entity_TrainJumpPrep
; Waits for timer then changes to falling animation
Entity_TrainJumpWait:                                   ; DATA XREF: ROM:0002EF48   o  ; was: sub_2F01A
                subq.w  #1,$48(a5)
                bne.s   locret_2F030
                move.l  #word_EBD7A,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
locret_2F030:                                           ; CODE XREF: Entity_TrainJumpWait+4   j
                rts
; End of function Entity_TrainJumpWait
; Handles player falling from train with gravity
Entity_TrainJumpFall:                                   ; DATA XREF: ROM:0002EF4A   o  ; was: sub_2F032
                btst    #7,$1C(a5)
                bne.s   loc_2F048
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s   Entity_TrainJumpLanded
loc_2F048:                                              ; CODE XREF: Entity_TrainJumpFall+6   j
                addi.l  #$4000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Train jump landed state setting up animation and next phase
Entity_TrainJumpLanded:                                 ; CODE XREF: Entity_TrainJumpFall+14   j  ; was: loc_2F052
                clr.l   $18(a5)
                move.w  #$80,$48(a5)
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                addq.w  #2,4(a5)
                rts
; End of function Entity_TrainJumpFall
; Completes train jump restoring palette and flags
Entity_TrainJumpComplete:                               ; DATA XREF: ROM:0002EF4C   o  ; was: sub_2F06E
                subq.w  #1,$48(a5)
                bne.s   locret_2F08A
                move.w  #$1000,2(a5)
                clr.w   (word_FFA02A).w
                lea     (byte_C1A2).l,a0
                jmp     LoadPalette
; ---------------------------------------------------------------------------
locret_2F08A:                                           ; CODE XREF: Entity_TrainJumpComplete+4   j
                rts
; End of function Entity_TrainJumpComplete
; Xi-Tiger intro entity initialization
Entity_XiTigerIntro:                                    ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F08C
                clr.w   6(a5)
                move.w  4(a5),d0
                lea     off_2F09C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Entity_XiTigerIntro
; ---------------------------------------------------------------------------
off_2F09C:      dc.w    Entity_XiTigerIntroDispatcher-*  ; DATA XREF: Entity_XiTigerIntro+8   o
                dc.w    Entity_XiTigerIntroStartState-*
                dc.w    Entity_XiTigerIntroState2-*
                dc.w    Boss_XiTigerIntroState3-*
                dc.w    Boss_XiTigerIntroState4-*
                dc.w    Boss_XiTigerIntroState5-*

; Dispatcher for Xi-Tiger intro states
Entity_XiTigerIntroDispatcher:                          ; DATA XREF: ROM:off_2F09C   o  ; was: sub_2F0A8
                addq.w  #2,4(a5)
                bsr.w   Entity_TrainEndLoadPalette
                bsr.w   Entity_XiTigerIntroState1
                move.w  #$60,$10(a5)                    ; '`'
                rts
; End of function Entity_XiTigerIntroDispatcher
; Xi-Tiger intro state with animation
Entity_XiTigerIntroState1:                              ; CODE XREF: Entity_XiTigerIntroDispatcher+8   p  ; was: sub_2F0BC
                                        ; Entity_XiTigerIntroStartState+6   p
                move.w  (dword_FFA904).w,$14(a5)
                addi.w  #$128,$14(a5)
                rts
; End of function Entity_XiTigerIntroState1
; Xi-Tiger intro start state
Entity_XiTigerIntroStartState:                          ; DATA XREF: ROM:0002F09E   o  ; was: sub_2F0CA
                move.w  #$60,$10(a5)                    ; '`'
                bsr.w   Entity_XiTigerIntroState1
                tst.w   (dword_FFA908).w
                bpl.s   locret_2F0F4
                move.l  #$FFFA0000,$1C(a5)
                move.w  #2,$18(a5)
                move.l  #word_EBD7A,8(a5)
                addq.w  #2,4(a5)
locret_2F0F4:                                           ; CODE XREF: Entity_XiTigerIntroStartState+E   j
                rts
; End of function Entity_XiTigerIntroStartState
; Xi-Tiger intro state advancing to cutscene
Entity_XiTigerIntroState2:                              ; DATA XREF: ROM:0002F0A0   o  ; was: sub_2F0F6
                btst    #7,$1C(a5)
                bne.s   loc_2F10C
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s   loc_2F116
loc_2F10C:                                              ; CODE XREF: Entity_XiTigerIntroState2+6   j
                addi.l  #$4000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
loc_2F116:                                              ; CODE XREF: Entity_XiTigerIntroState2+14   j
                clr.l   $18(a5)
                move.l  #word_EBD5C,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Entity_XiTigerIntroState2
; Xi Tiger boss intro state 3 with animation and sound trigger
Boss_XiTigerIntroState3:                                ; DATA XREF: ROM:0002F0A2   o  ; was: sub_2F132
                bsr.w   Entity_XiTigerIntroState1
                subq.w  #1,$48(a5)
                bne.s   locret_2F160
                move.l  #word_EBD32,8(a5)
                clr.w   $C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                clr.w   $4A(a5)
                addq.w  #2,4(a5)
                move.b  #$20,d0                         ; ' '
                jsr     (Sound_PlaySFX).l
locret_2F160:                                           ; CODE XREF: Boss_XiTigerIntroState3+8   j
                rts
; End of function Boss_XiTigerIntroState3
; Xi Tiger boss intro state 4 with animation cycling
Boss_XiTigerIntroState4:                                ; DATA XREF: ROM:0002F0A4   o  ; was: sub_2F162
                bsr.w   Entity_XiTigerIntroState1
                subq.w  #1,$48(a5)
                bne.s   locret_2F192
                move.w  $4A(a5),d0
                lsl.w   #2,d0
                move.l  off_2F194(pc,d0.w),8(a5)
                clr.w   $C(a5)
                move.w  #4,$48(a5)
                addq.w  #1,$4A(a5)
                cmpi.w  #2,$4A(a5)
                bne.s   locret_2F192
                addq.w  #2,4(a5)
locret_2F192:                                           ; CODE XREF: Boss_XiTigerIntroState4+8   j
                                        ; Boss_XiTigerIntroState4+2A   j
                rts
; End of function Boss_XiTigerIntroState4
; ---------------------------------------------------------------------------
off_2F194:      dc.l    word_EBD02                      ; DATA XREF: Boss_XiTigerIntroState4+10   r
                dc.l    word_EBCD8

; Xi Tiger boss intro state 5 continuing intro animation
Boss_XiTigerIntroState5:                                ; DATA XREF: ROM:0002F0A6   o  ; was: sub_2F19C
                bsr.w   Entity_XiTigerIntroState1
                rts
; End of function Boss_XiTigerIntroState5
; Xi Tiger boss main attack pattern dispatcher
