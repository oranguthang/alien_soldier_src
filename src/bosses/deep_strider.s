; Deep Strider controller, attack states, and linked-part rendering
Boss_DeepStriderMain:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3E582
                tst.w   4(a5)
                beq.w   Boss_DeepStriderStateDispatch
                tst.w   8(a5)
                beq.s   Boss_DeepStriderStateDispatch
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3E5A8
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3E5A8
                tst.w   (word_FF8200).w
                beq.w   Boss_DeepStriderReviveInit
loc_3E5A8:                                              ; CODE XREF: Boss_DeepStriderMain+14   j
                                        ; Boss_DeepStriderMain+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
; State machine dispatcher for Deep Strider boss
Boss_DeepStriderStateDispatch:                          ; CODE XREF: Boss_DeepStriderMain+4   j  ; was: loc_3E5BA
                                        ; Boss_DeepStriderMain+C   j
                move.w  4(a5),d0
                movea.w off_3E5CA(pc,d0.w),a0
                adda.l  #Boss_DeepStriderInit,a0
                jmp     (a0)
; End of function Boss_DeepStriderMain
; ---------------------------------------------------------------------------
off_3E5CA:      dc.w    Boss_DeepStriderInit-Boss_DeepStriderInit
                                        ; DATA XREF: Boss_DeepStriderMain+3C   r
                dc.w    Boss_DeepStriderIntroRise-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntro_RisingPhase-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroWait-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIntroDive-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDiveSetup-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDeathStart-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDeathRotate-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDeathSequence-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDefeatDelay-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattle_DescendPhase-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattle_WaitTimer-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattle_AscendPhase-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderIdleTimer-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDiveCheck-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderRevive_PaletteFade-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderReviveRise-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderReviveComplete-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderDefeatFinal-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattle_HoverAndShoot-Boss_DeepStriderInit
                dc.w    Boss_DeepStriderBattle_PostDiveRise-Boss_DeepStriderInit

; Initializes Deep Strider boss state
Boss_DeepStriderInit:                                   ; DATA XREF: Boss_DeepStriderMain+40   o  ; was: sub_3E5F4
                                        ; ROM:off_3E5CA   o
                addq.w  #2,4(a5)
                clr.w   8(a5)
; End of function Boss_DeepStriderInit
; Clears sprites except boss
Boss_DeepStriderClearSprites:                           ; CODE XREF: Boss_DeepStriderReviveRise+38   p  ; was: sub_3E5FC
                move.w  #$19C,d0
                move.w  #$208,d1
                jmp     Object_ClearAllExceptTypes
; End of function Boss_DeepStriderClearSprites
; Boss intro rise sequence
Boss_DeepStriderIntroRise:                              ; DATA XREF: ROM:0003E5CC   o  ; was: sub_3E60A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$D,d7
                movea.l #off_3F000,a0
                movea.l #word_3F038,a1
                movea.l #word_3F046,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$19C,(a5)
                bset    #0,$2A2(a5)
                move.w  #$D00,$4E2(a5)
                lea     (Boss_DeepStriderObjectInitTable).l,a1
                jsr     (Object_InitGroupFromTable).l
                move.w  #4,4(a5)
                move.w  #$180,$536(a5)
                move.w  #$B8,$4F0(a5)
                move.w  #$60,$4F4(a5)                   ; '`'
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.w  #$100,$54(a5)
                move.w  #$80,$56(a5)
                move.w  #$1E2,$1DC(a5)
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5)                   ; ' '
                move.w  #$1E0,$23E(a5)
                move.l  #$12000,$4FC(a5)
                clr.w   $11C(a5)
; Deep Strider intro rising with projectiles
Boss_DeepStriderIntro_RisingPhase:                      ; DATA XREF: ROM:0003E5CE   o  ; was: loc_3E6A0
                tst.w   $11C(a5)
                bne.s   loc_3E6C0
                cmpi.w  #$110,$4F4(a5)
                bmi.s   loc_3E6C0
                addq.w  #1,$11C(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnProjectiles
loc_3E6C0:                                              ; CODE XREF: Boss_DeepStriderIntroRise+9A   j
                                        ; Boss_DeepStriderIntroRise+A2   j
                addq.w  #1,$1DC(a5)
                addi.l  #$3C00,$4FC(a5)
                cmpi.w  #$1E0,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                clr.l   $4FC(a5)
                move.w  #$34,$11C(a5)                   ; '4'
; Waits during intro rise before next state
Boss_DeepStriderIntroWait:                              ; DATA XREF: ROM:0003E5D0   o  ; was: loc_3E6E4
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #2,$29C(a5)
                move.w  #$100,$54(a5)
                bsr.w   Boss_DeepStriderSetupPosition
; End of function Boss_DeepStriderIntroRise
; Boss intro dive sequence
Boss_DeepStriderIntroDive:                              ; DATA XREF: ROM:0003E5D2   o  ; was: sub_3E700
                bsr.w   Boss_DeepStriderDiveSequence
                bmi.w   locret_3EED6
                addq.w  #2,4(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
                move.w  #$38,$11C(a5)                   ; '8'
; Sets up dive parameters and velocities
Boss_DeepStriderDiveSetup:                              ; DATA XREF: ROM:0003E5D4   o  ; was: loc_3E71A
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$198,$4F0(a5)
                move.w  #$160,$4F4(a5)
                clr.w   $54(a5)
                move.w  #$1A0,$56(a5)
                move.w  #$28,$1DC(a5)                   ; '('
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5)                   ; ' '
                move.w  #0,$23E(a5)
                move.l  #$FFFF0000,$4F8(a5)
                move.l  #$FFF80000,$4FC(a5)
                clr.w   $11C(a5)
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnProjectiles
; End of function Boss_DeepStriderIntroDive
; Starts boss death sequence
Boss_DeepStriderDeathStart:                             ; DATA XREF: ROM:0003E5D6   o  ; was: sub_3E776
                subq.w  #1,$1DE(a5)
                subq.w  #1,$1DC(a5)
                subq.w  #1,$56(a5)
                addi.l  #$3800,$4FC(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                cmpi.w  #$120,$2B4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$120,$2B4(a5)
                move.w  #$C8C0,$48(a5)
                move.w  #$C8C0,$4A(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
; Rotates boss during death sequence
Boss_DeepStriderDeathRotate:                            ; DATA XREF: ROM:0003E5D8   o  ; was: loc_3E7B6
                subq.w  #6,$56(a5)
                subq.w  #2,$1DC(a5)
                andi.w  #$1FE,$1DC(a5)
                cmpi.w  #$1E0,$1DC(a5)
                bne.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                clr.w   $11E(a5)
                clr.w   $17C(a5)
                moveq   #0,d0
                jsr     (UI_CheckVictoryCondition).l
                bra.s   Boss_DeepStriderDeathSequence
; End of function Boss_DeepStriderDeathStart
; Delay timer before defeat
Boss_DeepStriderDefeatDelay:                            ; DATA XREF: ROM:0003E5DC   o  ; was: sub_3E7E8
                subq.w  #1,$17E(a5)
                bpl.s   loc_3E80C
                bra.w   Boss_DeepStriderBattleLogic
; End of function Boss_DeepStriderDefeatDelay
; Boss death animation sequence
Boss_DeepStriderDeathSequence:                          ; CODE XREF: Boss_DeepStriderDeathStart+70   j  ; was: sub_3E7F2
                                        ; DATA XREF: ROM:0003E5DA   o
                tst.w   (word_FF80C2).w
                bne.s   loc_3E80C
                addq.w  #2,4(a5)
                move.w  #$40,$17E(a5)                   ; '@'
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
loc_3E80C:                                              ; CODE XREF: Boss_DeepStriderDefeatDelay+4   j
                                        ; Boss_DeepStriderDeathSequence+4   j
                andi.w  #$1FC,$1DE(a5)
                tst.w   $11E(a5)
                bpl.s   loc_3E86A
                tst.w   $17C(a5)
                bne.s   loc_3E844
                cmpi.w  #$1E0,$1DE(a5)
                beq.s   loc_3E82A
                addq.w  #4,$1DE(a5)
loc_3E82A:                                              ; CODE XREF: Boss_DeepStriderDeathSequence+32   j
                addq.w  #3,$56(a5)
                addq.w  #2,$1DC(a5)
                cmpi.w  #$1FA,$1DC(a5)
                bpl.s   loc_3E872
                subq.w  #1,$11C(a5)
                bmi.s   loc_3E872
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3E844:                                              ; CODE XREF: Boss_DeepStriderDeathSequence+2A   j
                cmpi.w  #$1C0,$1DE(a5)
                beq.s   loc_3E850
                subq.w  #4,$1DE(a5)
loc_3E850:                                              ; CODE XREF: Boss_DeepStriderDeathSequence+58   j
                subq.w  #3,$56(a5)
                subq.w  #2,$1DC(a5)
                cmpi.w  #$1D8,$1DC(a5)
                bmi.s   loc_3E872
                subq.w  #1,$11C(a5)
                bmi.s   loc_3E872
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3E86A:                                              ; CODE XREF: Boss_DeepStriderDeathSequence+24   j
                subq.w  #1,$11E(a5)
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3E872:                                              ; CODE XREF: Boss_DeepStriderDeathSequence+46   j
                                        ; Boss_DeepStriderDeathSequence+4C   j
                move.b  (dword_FFFF08).w,d0
                andi.w  #$F,d0
                addq.w  #6,d0
                move.w  d0,$11C(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                move.w  d0,$11E(a5)
                eori.w  #1,$17C(a5)
                bra.w   Boss_DeepStriderUpdateParts
; End of function Boss_DeepStriderDeathSequence
; Main battle logic with attack patterns and phase transitions
Boss_DeepStriderBattleLogic:                            ; CODE XREF: Boss_DeepStriderDefeatDelay+6   j  ; was: sub_3E896
                addq.w  #2,4(a5)
                move.w  #2,$11C(a5)
                move.w  #$80,$536(a5)
; Deep Strider battle descend with rotation
Boss_DeepStriderBattle_DescendPhase:                    ; DATA XREF: ROM:0003E5DE   o  ; was: loc_3E8A6
                andi.w  #$1FC,$1DE(a5)
                cmpi.w  #$1C0,$1DE(a5)
                beq.s   loc_3E8B8
                subq.w  #4,$1DE(a5)
loc_3E8B8:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1C   j
                subq.w  #3,$56(a5)
                subq.w  #2,$1DC(a5)
                cmpi.w  #$1CC,$1DC(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
; Deep Strider battle wait timer
Boss_DeepStriderBattle_WaitTimer:                       ; DATA XREF: ROM:0003E5E0   o  ; was: loc_3E8CE
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                clr.w   $11E(a5)
                addq.w  #2,$29C(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.l  #$1E000,$4F8(a5)
                move.l  #$FFFB0000,$4FC(a5)
                bclr    #0,$2A2(a5)
; Deep Strider battle ascend with projectiles
Boss_DeepStriderBattle_AscendPhase:                     ; DATA XREF: ROM:0003E5E2   o  ; was: loc_3E90A
                tst.w   $11E(a5)
                bne.s   loc_3E92A
                cmpi.w  #$150,$4F4(a5)
                bmi.s   loc_3E92A
                addq.w  #1,$11E(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnProjectiles
loc_3E92A:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+78   j
                                        ; Boss_DeepStriderBattleLogic+80   j
                addq.w  #6,$56(a5)
                addq.w  #1,$1DC(a5)
                subi.l  #$C00,$4F8(a5)
                addi.l  #$3C00,$4FC(a5)
                cmpi.w  #$1E0,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                move.w  #$B,$17C(a5)
loc_3E952:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+28A   j
                                        ; Boss_DeepStriderDiveCheck+10   j
                move.w  #$1A,4(a5)
                bclr    #0,(byte_FF825C).w
                move.b  #$10,$141(a5)
                move.w  #$18,$534(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                clr.l   $4F8(a5)
                clr.l   $4FC(a5)
                tst.w   (word_FFFF0E).w
                bne.s   loc_3E98C
                move.w  #$10,$11C(a5)
                bra.s   Boss_DeepStriderIdleTimer
; ---------------------------------------------------------------------------
loc_3E98C:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+EC   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addq.w  #4,d0
                move.w  d0,$11C(a5)
; Idle timer before attack selection
Boss_DeepStriderIdleTimer:                              ; CODE XREF: Boss_DeepStriderBattleLogic+F4   j  ; was: loc_3E99A
                                        ; DATA XREF: ROM:0003E5E4   o
                subq.w  #1,$11C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                subq.w  #1,$17C(a5)
                cmpi.w  #$A,$17C(a5)
                bpl.w   loc_3EB24
                tst.w   $17C(a5)
                bmi.w   loc_3E9DC
                btst    #0,(byte_FF8244).w
                beq.w   loc_3EB24
                moveq   #7,d0
                btst    #6,(byte_FF8244).w
                beq.w   loc_3E9D0
                moveq   #1,d0
loc_3E9D0:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+134   j
                move.w  (dword_FFFF08).w,d1
                and.w   d0,d1
                beq.s   loc_3E9DC
                bra.w   loc_3EB24
; ---------------------------------------------------------------------------
loc_3E9DC:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+11E   j
                                        ; Boss_DeepStriderBattleLogic+140   j
                move.w  #$26,4(a5)                      ; '&'
                move.w  #1,$534(a5)
                clr.w   $11C(a5)
                clr.w   $11E(a5)
                move.w  #$BF,$17C(a5)
                move.w  #$180,$56(a5)
                move.w  #$180,$536(a5)
                move.w  #$1F4,$1DC(a5)
                clr.w   $23C(a5)
                move.w  #$1E0,$1DE(a5)
                bsr.w   Boss_DeepStriderCalculateX
                move.w  d0,$4F0(a5)
                move.w  #$1B0,$4F4(a5)
; Deep Strider hovering with angle firing
Boss_DeepStriderBattle_HoverAndShoot:                   ; DATA XREF: ROM:0003E5F0   o  ; was: loc_3EA20
                jsr     (Physics_GetPlayerDelta).l
                move.w  #$100,$54(a5)
                tst.w   d1
                bpl.s   loc_3EA34
                clr.w   $54(a5)
loc_3EA34:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+198   j
                tst.w   $11E(a5)
                bne.s   loc_3EA48
                addq.w  #1,$56(a5)
                cmpi.w  #$190,$56(a5)
                beq.s   loc_3EA54
                bra.s   loc_3EA5A
; ---------------------------------------------------------------------------
loc_3EA48:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1A2   j
                subq.w  #1,$56(a5)
                cmpi.w  #$178,$56(a5)
                bne.s   loc_3EA5A
loc_3EA54:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1AE   j
                eori.w  #1,$11E(a5)
loc_3EA5A:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1B0   j
                                        ; Boss_DeepStriderBattleLogic+1BC   j
                tst.w   $11C(a5)
                beq.s   loc_3EA8E
                addi.l  #$C00,$4FC(a5)
                bmi.s   loc_3EA7C
                cmpi.l  #$10000,$4FC(a5)
                bmi.s   loc_3EA7C
                move.l  #$10000,$4FC(a5)
loc_3EA7C:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1D2   j
                                        ; Boss_DeepStriderBattleLogic+1DC   j
                cmpi.w  #$160,$4F4(a5)
                bmi.s   loc_3EAB8
                tst.w   $17C(a5)
                bmi.w   loc_3EACE
                bra.s   loc_3EAB2
; ---------------------------------------------------------------------------
loc_3EA8E:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1C8   j
                subi.l  #$1000,$4FC(a5)
                bpl.s   loc_3EAAA
                cmpi.l  #$FFFF0000,$4FC(a5)
                bpl.s   loc_3EAAA
                move.l  #$FFFF0000,$4FC(a5)
loc_3EAAA:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+200   j
                                        ; Boss_DeepStriderBattleLogic+20A   j
                cmpi.w  #$170,$4F4(a5)
                bpl.s   loc_3EAB8
loc_3EAB2:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1F6   j
                eori.w  #1,$11C(a5)
loc_3EAB8:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1EC   j
                                        ; Boss_DeepStriderBattleLogic+21A   j
                subq.w  #1,$17C(a5)
                cmpi.w  #$9F,$17C(a5)
                bpl.w   Boss_DeepStriderUpdateParts
                bsr.w   Boss_DeepStriderFireAngleProjectile
                bra.w   Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
loc_3EACE:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+1F2   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                move.l  #$FFFB0000,$4FC(a5)
                move.b  #$4C,d0                         ; 'L'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnProjectiles
                move.w  #$B,$17C(a5)
; Deep Strider post-dive rising with scroll
Boss_DeepStriderBattle_PostDiveRise:                    ; DATA XREF: ROM:0003E5F2   o  ; was: loc_3EAF2
                addq.w  #1,$11C(a5)
                addi.l  #$3A00,$4FC(a5)
                subq.w  #8,$56(a5)
                subq.w  #1,$1DC(a5)
                cmpi.w  #$18,$11C(a5)
                bmi.s   loc_3EB16
                addq.w  #2,$1DC(a5)
                addq.w  #4,$56(a5)
loc_3EB16:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+276   j
                cmpi.w  #$1C0,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                bra.w   loc_3E952
; ---------------------------------------------------------------------------
loc_3EB24:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+116   j
                                        ; Boss_DeepStriderBattleLogic+128   j
                move.b  #$12,$141(a5)
                clr.w   $17E(a5)
                move.w  #$1C,4(a5)
                move.w  $29C(a5),d0
                beq.s   loc_3EB50
                cmpi.w  #4,d0
                bpl.s   loc_3EB4A
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   loc_3EB50
loc_3EB4A:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+2A8   j
                clr.w   $54(a5)
                bra.s   loc_3EB56
; ---------------------------------------------------------------------------
loc_3EB50:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+2A2   j
                                        ; Boss_DeepStriderBattleLogic+2B2   j
                move.w  #$100,$54(a5)
loc_3EB56:                                              ; CODE XREF: Boss_DeepStriderBattleLogic+2B8   j
                bsr.w   Boss_DeepStriderSetupPosition
; End of function Boss_DeepStriderBattleLogic
; Checks dive completion and damage state
Boss_DeepStriderDiveCheck:                              ; DATA XREF: ROM:0003E5E6   o  ; was: sub_3EB5A
                bsr.w   Boss_DeepStriderDiveSequence
                bmi.s   loc_3EB76
                tst.w   $54(a5)
                bne.s   loc_3EB6E
                subq.w  #2,$29C(a5)
                bra.w   loc_3E952
; ---------------------------------------------------------------------------
loc_3EB6E:                                              ; CODE XREF: Boss_DeepStriderDiveCheck+A   j
                addq.w  #2,$29C(a5)
                bra.w   loc_3E952
; ---------------------------------------------------------------------------
loc_3EB76:                                              ; CODE XREF: Boss_DeepStriderDiveCheck+4   j
                tst.w   $17E(a5)
                bne.s   loc_3EB90
                bclr    #1,$142(a5)
                beq.s   locret_3EBC8
                bset    #1,(byte_FF825C).w
                move.w  #2,$17E(a5)
loc_3EB90:                                              ; CODE XREF: Boss_DeepStriderDiveCheck+20   j
                bclr    #1,(byte_FF825C).w
                bne.s   loc_3EB9E
                clr.w   $17E(a5)
                rts
; ---------------------------------------------------------------------------
loc_3EB9E:                                              ; CODE XREF: Boss_DeepStriderDiveCheck+3C   j
                move.w  #$64,(word_FF824E).w            ; 'd'
                bset    #0,(byte_FF825C).w
                bset    #2,(byte_FF825C).w
                move.w  $130(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FF8250).w
                move.w  $134(a5),d0
                addi.w  #0,d0
                move.w  d0,(word_FF8252).w
locret_3EBC8:                                           ; CODE XREF: Boss_DeepStriderDiveCheck+28   j
                rts
; End of function Boss_DeepStriderDiveCheck
; Initializes boss revival sequence
Boss_DeepStriderReviveInit:                             ; CODE XREF: Boss_DeepStriderMain+22   j  ; was: sub_3EBCA
                move.w  #4,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #$1E,4(a5)
                move.w  #$CB00,$48(a5)
                move.w  #$CB00,$4A(a5)
                move.w  #$80,$536(a5)
                move.w  #$30,$1DC(a5)                   ; '0'
                move.w  #$1E0,$23C(a5)
                move.w  #$20,$1DE(a5)                   ; ' '
                move.w  #$1E0,$23E(a5)
                move.l  #$FFFBE000,$4FC(a5)
                move.l  #$FFFEE000,$4F8(a5)
                cmpi.w  #$880,$BC(a5)
                bpl.s   Boss_DeepStriderRevive_PaletteFade
                neg.l   $4F8(a5)
; Fades palette and spawns debris during revival
Boss_DeepStriderRevive_PaletteFade:                     ; CODE XREF: Boss_DeepStriderReviveInit+5E   j  ; was: loc_3EC2E
                                        ; DATA XREF: ROM:0003E5E8   o
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_DeepStriderSpawnDebris
                addi.w  #$10,$56(a5)
                addi.l  #$2000,$4FC(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                cmpi.w  #$150,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  #4,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                move.l  #$FFFEE000,$4FC(a5)
                move.b  #$4D,d0                         ; 'M'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnProjectiles
; End of function Boss_DeepStriderReviveInit
; Boss rises during revival
Boss_DeepStriderReviveRise:                             ; DATA XREF: ROM:0003E5EA   o  ; was: sub_3EC7A
                jsr     (Gfx_UpdatePaletteFade).l
                addi.w  #$10,$56(a5)
                addi.l  #$2000,$4FC(a5)
                cmpi.w  #$180,$4F4(a5)
                bmi.w   Boss_DeepStriderUpdateParts
                addq.w  #2,4(a5)
                move.w  $4F0(a5),$10(a5)
                move.w  #$30,$48(a5)                    ; '0'
                move.w  #$100,2(a5)
                clr.w   8(a5)
                bsr.w   Boss_DeepStriderClearSprites
; End of function Boss_DeepStriderReviveRise
; Completes boss revival with debris
Boss_DeepStriderReviveComplete:                         ; DATA XREF: ROM:0003E5EC   o  ; was: sub_3ECB6
                jsr     (Gfx_UpdatePaletteFade).l
                subq.w  #1,$48(a5)
                bpl.w   locret_3EED6
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #8,(word_FFA010).w
                move.w  #4,(word_FFA014).w
                movea.w a5,a0
                move.l  #$FFF80000,d4
                move.w  $10(a5),d5
loc_3ECE6:                                              ; CODE XREF: Boss_DeepStriderReviveComplete+60   j
                lea     $60(a0),a0
                move.b  #$30,d0                         ; '0'
                jsr     (Sound_PlaySFX).l
                jsr     (Projectile_InitType1A8).l
                move.l  #off_E953C,8(a0)
                move.l  d4,$1C(a0)
                move.w  #$150,$14(a0)
                move.w  d5,$10(a0)
                addi.l  #$8000,d4
                bmi.s   loc_3ECE6
; End of function Boss_DeepStriderReviveComplete
; Final defeat of Deep Strider
Boss_DeepStriderDefeatFinal:                            ; DATA XREF: ROM:0003E5EE   o  ; was: sub_3ED18
                subq.w  #1,$48(a5)
                bpl.s   locret_3ED24
                bset    #4,2(a5)
locret_3ED24:                                           ; CODE XREF: Boss_DeepStriderDefeatFinal+4   j
                rts
; End of function Boss_DeepStriderDefeatFinal
; Spawns debris projectiles during Deep Strider boss revival
Boss_DeepStriderSpawnDebris:                            ; CODE XREF: Boss_DeepStriderReviveInit+6A   p  ; was: sub_3ED26
                move.w  #2,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                btst    #0,(word_FFA000+1).w
                bne.s   locret_3ED9A
                jsr     (Projectile_FindFreeOrRecycleSlot).l
                bne.s   locret_3ED9A
                jsr     (Sprite_InitType160).l
                move.l  #off_E953C,8(a0)
                move.b  (dword_FFFF08).w,d1
                andi.w  #3,d1
                bne.s   loc_3ED62
                move.l  #off_E95DC,8(a0)
loc_3ED62:                                              ; CODE XREF: Boss_DeepStriderSpawnDebris+32   j
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                subi.w  #$10,d0
                move.w  $4F0(a5),$10(a0)
                add.w   d0,$10(a0)
                move.w  $4F4(a5),$14(a0)
                move.l  #$FFFC2000,$1C(a0)
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   locret_3ED9A
                move.b  #$BC,d0
                jmp     (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_3ED9A:                                           ; CODE XREF: Boss_DeepStriderSpawnDebris+12   j
                                        ; Boss_DeepStriderSpawnDebris+1A   j
                rts
; End of function Boss_DeepStriderSpawnDebris
; Spawns quad projectile pattern
Boss_DeepStriderSpawnProjectiles:                       ; CODE XREF: Boss_DeepStriderIntroRise+B2   p  ; was: sub_3ED9C
                                        ; Boss_DeepStriderIntroDive+72   p
                move.w  $D0(a5),d5
                move.w  #$150,d6
                jmp     Projectile_SpawnQuadPattern
; End of function Boss_DeepStriderSpawnProjectiles
; Sets up boss position and velocity
Boss_DeepStriderSetupPosition:                          ; CODE XREF: Boss_DeepStriderIntroRise+F2   p  ; was: sub_3EDAA
                                        ; sub_3E896:loc_3EB56   p
                move.w  #$180,$536(a5)
                clr.w   $11C(a5)
                bsr.w   Boss_DeepStriderCalculateX
                move.w  d0,$4F0(a5)
                move.w  #$160,$4F4(a5)
                move.w  #$17C,$56(a5)
                move.w  #$1FC,$1DC(a5)
                move.w  #$1A0,$1DE(a5)
                move.w  #$20,$23C(a5)                   ; ' '
                move.w  #$1B0,$23E(a5)
                move.l  #$FFFC4800,$4F8(a5)
                move.l  #$FFFA0000,$4FC(a5)
                tst.w   $54(a5)
                beq.s   locret_3EDFA
                neg.l   $4F8(a5)
locret_3EDFA:                                           ; CODE XREF: Boss_DeepStriderSetupPosition+4A   j
                rts
; End of function Boss_DeepStriderSetupPosition
; Calculates boss X coordinate
Boss_DeepStriderCalculateX:                             ; CODE XREF: Boss_DeepStriderBattleLogic+17C   p  ; was: sub_3EDFC
                                        ; Boss_DeepStriderSetupPosition+A   p
                moveq   #0,d2
                move.w  $29C(a5),d0
                move.w  word_3EE14(pc,d0.w),d0
                move.w  (dword_FFA900).w,d1
                subi.w  #$710,d1
                sub.w   d1,d0
                add.w   d2,d0
                rts
; End of function Boss_DeepStriderCalculateX
; ---------------------------------------------------------------------------
word_3EE14:     dc.w    $90, $170, $250                 ; DATA XREF: Boss_DeepStriderCalculateX+6   r

; Boss dive attack sequence
Boss_DeepStriderDiveSequence:                           ; CODE XREF: Boss_DeepStriderIntroDive   p  ; was: sub_3EE1A
                                        ; sub_3EB5A   p
                addq.w  #1,$11C(a5)
                move.b  #$4C,d0                         ; 'L'
                cmpi.w  #3,$11C(a5)
                beq.s   loc_3EE36
                move.b  #$4D,d0                         ; 'M'
                cmpi.w  #$32,$11C(a5)                   ; '2'
                bne.s   loc_3EE40
loc_3EE36:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+E   j
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_DeepStriderSpawnProjectiles
loc_3EE40:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+1A   j
                subq.w  #4,$56(a5)
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_3EE52
                addq.w  #1,$56(a5)
loc_3EE52:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+32   j
                cmpi.w  #$11,$11C(a5)
                bmi.s   loc_3EE7C
                cmpi.w  #$34,$11C(a5)                   ; '4'
                bpl.s   loc_3EE70
                cmpi.w  #$1F4,$1DC(a5)
                beq.s   loc_3EE7C
                subq.w  #1,$1DC(a5)
                bra.s   loc_3EE7C
; ---------------------------------------------------------------------------
loc_3EE70:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+46   j
                cmpi.w  #$1FC,$1DC(a5)
                beq.s   loc_3EE7C
                addq.w  #1,$1DC(a5)
loc_3EE7C:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+3E   j
                                        ; Boss_DeepStriderDiveSequence+4E   j
                cmpi.w  #$1A,$11C(a5)
                bmi.s   loc_3EE90
                cmpi.w  #$1F0,$23E(a5)
                beq.s   loc_3EE90
                addq.w  #1,$23E(a5)
loc_3EE90:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+68   j
                                        ; Boss_DeepStriderDiveSequence+70   j
                cmpi.w  #$1F8,$1DE(a5)
                beq.s   loc_3EE9C
                addq.w  #1,$1DE(a5)
loc_3EE9C:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+7C   j
                cmpi.w  #$30,$11C(a5)                   ; '0'
                bmi.s   loc_3EEBC
                tst.w   $4F8(a5)
                bmi.s   loc_3EEB4
                subi.l  #$3000,$4F8(a5)
                bra.s   loc_3EEBC
; ---------------------------------------------------------------------------
loc_3EEB4:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+8E   j
                addi.l  #$3000,$4F8(a5)
loc_3EEBC:                                              ; CODE XREF: Boss_DeepStriderDiveSequence+88   j
                                        ; Boss_DeepStriderDiveSequence+98   j
                bsr.w   Boss_DeepStriderUpdateParts
                addi.l  #$3200,$4FC(a5)
                bmi.w   locret_3EED6
                cmpi.w  #$1E0,$14(a5)
                bmi.w   *+4
locret_3EED6:                                           ; CODE XREF: Boss_DeepStriderIntroDive+4   j
                                        ; Boss_DeepStriderReviveComplete+A   j
                rts
; End of function Boss_DeepStriderDiveSequence
; Updates boss metasprite parts
Boss_DeepStriderUpdateParts:                            ; CODE XREF: Boss_DeepStriderIntroRise+C8   j  ; was: sub_3EED8
                                        ; Boss_DeepStriderIntroRise+DE   j
                move.w  #$1FF,d0
                and.w   d0,$56(a5)
                and.w   d0,$1DC(a5)
                and.w   d0,$1DE(a5)
                and.w   d0,$23C(a5)
                and.w   d0,$23E(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.w  $1DC(a5),d0
                moveq   #2,d7
; Updates rotation angles for body parts
Boss_DeepStriderUpdateAngles:                           ; CODE XREF: Boss_DeepStriderUpdateParts+28   j  ; was: loc_3EEFA
                move.w  (a0),d1
                move.w  d0,(a0)+
                move.w  d1,d0
                dbf     d7,Boss_DeepStriderUpdateAngles
                move.w  $1DC(a5),$B6(a5)
                move.w  (dword_FF9400).w,d0
                move.w  d0,d1
                add.w   d0,d1
                move.w  d1,$116(a5)
                move.w  (dword_FF9400+2).w,d0
                move.w  d0,d1
                add.w   d0,d1
                add.w   d0,d1
                move.w  d1,$176(a5)
                move.w  $1DC(a5),d0
                move.w  #$100,d1
                sub.w   d0,d1
                move.w  d1,$1D6(a5)
                move.w  (dword_FF9400).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$236(a5)
                move.w  (dword_FF9400+2).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$296(a5)
                move.w  (dword_FF9404).w,d0
                move.w  #$100,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                sub.w   d0,d1
                move.w  d1,$2F6(a5)
                move.w  d1,d2
                addi.w  #$80,d1
                add.w   $23E(a5),d1
                move.w  d1,$356(a5)
                subi.w  #$80,d2
                sub.w   $23E(a5),d2
                move.w  d2,$3B6(a5)
                move.w  $B6(a5),d1
                addi.w  #$80,d1
                add.w   $23C(a5),d1
                move.w  d1,$4D6(a5)
                move.w  $116(a5),d2
                subi.w  #$80,d2
                add.w   $1DE(a5),d2
                move.w  d2,$416(a5)
                move.w  d2,$476(a5)
                moveq   #$C,d7
                jmp     Sprite_UpdateMetaspriteFourFrameRotationAndLoadCount
; End of function Boss_DeepStriderUpdateParts
; ---------------------------------------------------------------------------
off_3EFAE:      dc.l    word_EBDE6                      ; DATA XREF: ROM:0003F00C   o
                dc.l    word_EBDDA
                dc.l    word_EBDD4
                dc.l    word_EBDCE
off_3EFBE:      dc.l    word_EBE16                      ; DATA XREF: ROM:0003F004   o
                                        ; ROM:0003F008   o
                dc.l    word_EBE10
                dc.l    word_EBE0A
                dc.l    word_EBE04
off_3EFCE:      dc.l    word_EBE5E                      ; DATA XREF: ROM:0003F024   o
                                        ; ROM:0003F030   o
                dc.l    word_EBE58
                dc.l    word_EBE52
                dc.l    word_EBE4C
off_3EFDE:      dc.l    word_EBE4C                      ; DATA XREF: ROM:0003F020   o
                                        ; ROM:0003F02C   o
                dc.l    word_EBE52
                dc.l    word_EBE58
                dc.l    word_EBE5E
word_3EFEE:     dc.w    $6397, $A00, $F4F4              ; DATA XREF: ROM:0003F014   o
                                        ; ROM:0003F028   o
word_3EFF4:     dc.w    $63A0, $500, $F8F8              ; DATA XREF: ROM:0003F018   o
word_3EFFA:     dc.w    $63A4, $500, $F8F8              ; DATA XREF: ROM:0003F01C   o
off_3F000:      dc.l    word_EBE7C+$400000              ; DATA XREF: Boss_DeepStriderIntroRise+E   o
                dc.l    off_3EFBE
                dc.l    off_3EFBE
                dc.l    off_3EFAE
                dc.l    word_EBE7C+$400000
                dc.l    word_3EFEE+1
                dc.l    word_3EFF4+1
                dc.l    word_3EFFA+1
                dc.l    off_3EFDE+$28000000
                dc.l    off_3EFCE
                dc.l    word_3EFEE+1
                dc.l    off_3EFDE+$28000000
                dc.l    off_3EFCE
                dc.l    0
word_3F038:     dc.w    $15, $1210, $1410               ; DATA XREF: Boss_DeepStriderIntroRise+14   o
                dc.w    $C0A, $C0C, $E10
                dc.w    $1418
word_3F046:     dc.w    $C007, $C006, $C065
                                        ; DATA XREF: Boss_DeepStriderIntroRise+1A   o
                dc.w    $C0C4, $C007, $C187
                dc.w    $C1E7, $C247, $C2A7
                dc.w    $C2A7, $C0C4, $C3C4
                dc.w    $C067, 7

; Fires angled projectile from Deep Strider boss using sine table
Boss_DeepStriderFireAngleProjectile:                    ; CODE XREF: Boss_DeepStriderBattleLogic+230   p  ; was: sub_3F062
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.w   locret_3F112
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.w   locret_3F112
                move.w  #$350,(a0)
                move.w  #$AD80,2(a0)
                move.w  #$4411,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$10,$20(a0)
                move.b  #$40,$21(a0)                    ; '@'
                move.w  #$50,$26(a0)                    ; 'P'
                move.l  #$FF01FF01,$2C(a0)
                move.w  (dword_FFFF08).w,d3
                ext.l   d3
                asl.l   #2,d3
                lea     (Math_SineTable).l,a1
                move.w  $56(a5),d7
                addi.w  #$20,d7                         ; ' '
                andi.w  #$1FE,d7
                move.w  -$80(a1,d7.w),d0
                move.w  (a1,d7.w),d1
                ext.l   d0
                ext.l   d1
                asl.l   #4,d0
                asl.l   #3,d1
                move.l  d0,$1C(a0)
                clr.l   $18(a0)
                move.w  $134(a5),$14(a0)
                addq.w  #2,$14(a0)
                move.w  $130(a5),$10(a0)
                btst    #3,$12E(a5)
                beq.s   loc_3F106
                subq.w  #4,$10(a0)
                sub.l   d3,$18(a0)
                sub.l   d1,$18(a0)
                rts
; ---------------------------------------------------------------------------
loc_3F106:                                              ; CODE XREF: Boss_DeepStriderFireAngleProjectile+94   j
                addq.w  #4,$10(a0)
                add.l   d3,$18(a0)
                add.l   d1,$18(a0)
locret_3F112:                                           ; CODE XREF: Boss_DeepStriderFireAngleProjectile+8   j
                                        ; Boss_DeepStriderFireAngleProjectile+12   j
                rts
; End of function Boss_DeepStriderFireAngleProjectile
; Handles enemy bouncing on floor collision or spawning explosion
Enemy_BounceOnFloorOrExplode:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3F114
                tst.w   (word_FF808C).w
                bpl.s   loc_3F14E
                bclr    #7,$22(a5)
                beq.s   loc_3F146
                bclr    #4,$22(a5)
                beq.s   loc_3F14E
                jsr     (Projectile_FindFreeSlot).l
                bne.s   loc_3F14E
                jsr     (Pickup_SpawnSmall).l
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                bra.s   loc_3F14E
; ---------------------------------------------------------------------------
loc_3F146:                                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+C   j
                jsr     (Collision_GetEntityPosition).l
                beq.s   loc_3F164
loc_3F14E:                                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+4   j
                                        ; Enemy_BounceOnFloorOrExplode+14   j
                neg.w   $18(a5)
                move.w  #$FFFE,$1C(a5)
                lea     (Projectile_SpawnSpriteFrames).l,a1  ; make offsets?
                jmp     Sprite_InitCurrentFromTable
; ---------------------------------------------------------------------------
loc_3F164:                                              ; CODE XREF: Enemy_BounceOnFloorOrExplode+38   j
                addi.l  #$E00,$1C(a5)
                bmi.s   locret_3F196
                cmpi.w  #$14C,$14(a5)
                bmi.s   locret_3F196
                clr.l   $18(a5)
                move.l  #$FFFC0000,$1C(a5)
loc_3F182:                                              ; CODE XREF: Enemy_FallingBombLogic+C0   p
                move.l  #off_1A0E96,8(a5)
                jsr     (Projectile_InitType88FromCurrent).l
                move.w  #$4000,$E(a5)
locret_3F196:                                           ; CODE XREF: Enemy_BounceOnFloorOrExplode+58   j
                                        ; Enemy_BounceOnFloorOrExplode+60   j
                rts
; End of function Enemy_BounceOnFloorOrExplode
; ---------------------------------------------------------------------------
off_3F198:      dc.l    word_EBFE0                      ; DATA XREF: Boss_GustheadMain+20   o
                dc.l    word_EBFF8

; Wrapper for Gusthead boss main
