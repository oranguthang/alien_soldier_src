UI_SetPasswordConfirmFlag:                              ; CODE XREF: UI_HandlePasswordInput+284   j  ; was: sub_1CCEC
                bset    #0,(byte_FFA209).w
                bra.s   loc_1CD02
; End of function UI_SetPasswordConfirmFlag
; Initializes game state variables for menu/title screen
UI_InitializeGameVariables:                             ; CODE XREF: UI_HandleTitleInput+8A   p  ; was: sub_1CCF4
                                        ; UI_HandleTitleInput+BA   j
                clr.w   (StageTableIndex).w
                move.w  #2,(word_FFA22A).w
                clr.b   (byte_FFA209).w
loc_1CD02:                                              ; CODE XREF: UI_SetPasswordConfirmFlag+6   j
                move.w  #$200,(word_FFA216).w
                move.w  #$200,(word_FFA218).w
                clr.l   (dword_FFA212).w
                clr.w   (word_FF822A).w
                move.w  #3,(word_FFA228).w
                clr.w   (word_FFFF40).w
                clr.w   (word_FFFF42).w
                clr.w   (word_FFFF44).w
                clr.w   (word_FFFF3E).w
                clr.w   (word_FF8090).w
                clr.b   (byte_FFFF31).w
                bsr.w   UI_InitializeScoreBuffer
                bra.s   loc_1CDB8
; End of function UI_InitializeGameVariables
; Initializes game state after continue, sets weapon ammo and clears menu flags
UI_InitGameStateFromContinue:                           ; CODE XREF: UI_TransitionFromContinue+28   j  ; was: sub_1CD3A
                                        ; UI_UpdatePasswordDisplay+12   j
                move.w  (word_FFA218).w,(word_FFA216).w
                tst.w   (word_FFFF0E).w
                beq.s   loc_1CD5A
                move.w  #$3E8,d0
                move.w  d0,(word_FFA268).w
                move.w  d0,(word_FFA26A).w
                move.w  d0,(word_FFA26C).w
                move.w  d0,(word_FFA26E).w
loc_1CD5A:                                              ; CODE XREF: UI_InitGameStateFromContinue+A   j
                move.w  (word_FFA268).w,(word_FFA260).w
                move.w  (word_FFA26A).w,(word_FFA262).w
                move.w  (word_FFA26C).w,(word_FFA264).w
                move.w  (word_FFA26E).w,(word_FFA266).w
                clr.l   (dword_FFA212).w
                clr.w   (word_FF822A).w
                clr.w   (word_FFFF42).w
                clr.w   (word_FFFF44).w
                clr.w   (word_FFFF3E).w
                clr.w   (word_FFA21C).w
                clr.w   (word_FF8090).w
                clr.b   (byte_FFFF31).w
                bsr.s   UI_ResetMenuBufferAndState
                move.w  #$50,(word_FF80C2).w            ; 'P'
                move.w  (StageTableIndex).w,d0
                asr.b   #1,d0
                move.b  byte_1CDCE(pc,d0.w),(dword_FF80C8).w
                rts
; End of function UI_InitGameStateFromContinue
; Clears password input flags and menu state variables
UI_ClearPasswordFlags:                                  ; CODE XREF: Password_HandleInput+12   p  ; was: sub_1CDA8
                clr.w   (word_FF822A).w
                clr.w   (word_FFA21C).w
                clr.w   (word_FF8090).w
; End of function UI_ClearPasswordFlags
; Clears menu buffer at FFE300 and resets menu state to 4
UI_ResetMenuBufferAndState:                             ; CODE XREF: UI_InitGameStateFromContinue+58   p  ; was: sub_1CDB4
                bsr.w   Enemy_UpdateBehavior
loc_1CDB8:                                              ; CODE XREF: UI_UpdateOptionsScreen+12   j
                                        ; Sys_RunOptionsMenuLoop+12   j
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #0,d0
                moveq   #$3F,d7                         ; '?'
; Clears menu buffer at word_FFE300 with 64 iterations
UI_ClearMenuBuffer:                                     ; CODE XREF: UI_ResetMenuBufferAndState+E   j  ; was: loc_1CDC0
                move.l  d0,(a0)+
                dbf     d7,UI_ClearMenuBuffer
                move.w  #4,(word_FFFF2A).w
                rts
; End of function UI_ResetMenuBufferAndState
; ---------------------------------------------------------------------------
byte_1CDCE:     dc.b    $18, $18, $18, $18, $18, $18, $18, $18, $18, $18
                                        ; DATA XREF: UI_InitGameStateFromContinue+66   r
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18, $18, 0
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18, $18, $18
                dc.b    $18, $18, $18, $18, $18, $18, $18, $18

; Stores current weapon selection value to buffer
UI_StoreWeaponSelection:                                ; CODE XREF: Text_AdvancePhase+30   p  ; was: sub_1CDF4
                movea.w #(word_FFAA00-M68K_RAM),a0
                move.w  (StageTableIndex).w,d0
                move.w  (word_FFA270).w,(a0,d0.w)
                rts
; End of function UI_StoreWeaponSelection
; Store weapon selection to buffer
UI_StoreWeaponToBuffer:                                 ; CODE XREF: Text_CompleteWithSound:loc_B0FE   p  ; was: sub_1CE04
                                        ; Boss_ZLeoDefeatedDelay+2E   j
                movea.w #(word_FFAA80-M68K_RAM),a0
                move.w  (StageTableIndex).w,d0
                move.w  (word_FFA270).w,(a0,d0.w)
                rts
; End of function UI_StoreWeaponToBuffer
; Increments score counter with maximum value check
UI_IncrementScoreCounter:                               ; CODE XREF: Results_UpdateAndDisplay+2A   p  ; was: sub_1CE14
                movea.w #(word_FFAB00-M68K_RAM),a0
                adda.w  (StageTableIndex).w,a0
                cmpi.w  #$3E7,(a0)
                bpl.s   locret_1CE24
                addq.w  #1,(a0)
locret_1CE24:                                           ; CODE XREF: UI_IncrementScoreCounter+C   j
                rts
; End of function UI_IncrementScoreCounter
; Initializes score buffer with -1 values
UI_InitializeScoreBuffer:                               ; CODE XREF: UI_InitializeGameVariables+40   p  ; was: sub_1CE26
                movea.w #(word_FFAA00-M68K_RAM),a0
                move.w  #$FFFF,d0
                move.w  #$BF,d7
; Loop that fills score buffer with data
UI_InitScoreBufferLoop:                                 ; CODE XREF: UI_InitializeScoreBuffer+E   j  ; was: loc_1CE32
                move.w  d0,(a0)+
                dbf     d7,UI_InitScoreBufferLoop
                rts
; End of function UI_InitializeScoreBuffer
; Updates enemy AI behavior state
Enemy_UpdateBehavior:                                   ; CODE XREF: Player_Initialize+4   p  ; was: sub_1CE3A
                                        ; sub_1CDB4   p
                lea     word_1CE4C(pc),a0
                nop
                move.w  (StageTableIndex).w,d0
                move.w  (a0,d0.w),(word_FFA270).w
                rts
; End of function Enemy_UpdateBehavior
; ---------------------------------------------------------------------------
word_1CE4C:     dc.w    $200, $240, $300, $330, $330
                                        ; DATA XREF: Enemy_UpdateBehavior   o
                                        ; Results_InitializeDataDisplay+4E   o
                dc.w    $210, $220, $300, $340, $300
                dc.w    $320, $410, $200, $200, $240
                dc.w    $340, $300, $400, $220, $950
                dc.w    $200, $200, $410, $220, $555

; Sets up results screen graphics and memory state
