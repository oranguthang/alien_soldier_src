; Seven Forces Valkirie, Medusa, Sylpheed, and Artemis form states
; State C: fade in the Valkirie palette, then arm its hold timer
Entity_SevenForcesValkirieFadeInStateC:                 ; DATA XREF: ROM:00054BA4   o  ; was: sub_54F9E
                subq.w  #1,$48(a5)
                bpl.w   Entity_SevenForcesNoOpState
                addq.w  #1,$5E(a5)
                cmpi.w  #$E,$5E(a5)
                bmi.s   Entity_SevenForcesValkirieFadeInApplyPalette
                addq.w  #2,4(a5)
                move.w  #$34,$48(a5)                    ; '4'
                clr.w   2(a5)
                move.b  #$96,d0
                jsr     (Sound_QueueBGMRequest).l
                move.b  #$23,d0                         ; '#'
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesValkirieAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesValkirieFadeInApplyPalette:           ; CODE XREF: Entity_SevenForcesValkirieFadeInStateC+12   j  ; was: loc_54FE0
                bra.w   Gfx_UpdateSevenForcesValkiriePaletteFade
; End of function Entity_SevenForcesValkirieFadeInStateC
; State E: count down Valkirie hold and fade-out values, then reset
Entity_SevenForcesValkirieFadeOutStateE:                ; DATA XREF: ROM:00054BA6   o  ; was: sub_54FE4
                subq.w  #1,$48(a5)
                bpl.w   Gfx_UpdateSevenForcesValkiriePaletteFade
                subq.w  #1,$5E(a5)
                bpl.w   Gfx_UpdateSevenForcesValkiriePaletteFade
Entity_SevenForcesResetState:                           ; CODE XREF: Entity_SevenForcesMedusaFadeOutState16+16   j  ; was: loc_54FF4
                                        ; Entity_SevenForcesSylpheedFadeOutState20+16   j
                clr.w   4(a5)
                rts
; End of function Entity_SevenForcesValkirieFadeOutStateE
; State $10: launch the Medusa entrance trajectory
Entity_SevenForcesStartMedusaEntranceState10:           ; DATA XREF: ROM:00054BA8   o  ; was: sub_54FFA
                addq.w  #2,4(a5)
                move.l  #$FFFCC000,$1C(a5)
                move.l  #$12000,$18(a5)
                cmpi.w  #$150,$10(a5)
                bmi.s   Entity_SevenForcesUpdateMedusaEntranceState12
                neg.l   $18(a5)
; State $12: apply gravity until Medusa reaches the landing threshold
Entity_SevenForcesUpdateMedusaEntranceState12:          ; CODE XREF: Entity_SevenForcesStartMedusaEntranceState10+1A   j  ; was: loc_5501A
                                        ; DATA XREF: ROM:00054BAA   o
                addi.l  #$2800,$1C(a5)
                bmi.s   Entity_SevenForcesUpdateMedusaEntrancePalette
                cmpi.w  #$F0,$14(a5)
                bmi.s   Entity_SevenForcesUpdateMedusaEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesMedusaAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
                move.b  #1,(SceneSequenceFlags).w
Entity_SevenForcesUpdateMedusaEntrancePalette:          ; CODE XREF: Entity_SevenForcesStartMedusaEntranceState10+28   j  ; was: loc_55056
                                        ; Entity_SevenForcesStartMedusaEntranceState10+30   j
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesStartMedusaEntranceState10
; State $14: hold Medusa, play the timed cue, and update its palette
Entity_SevenForcesMedusaHoldState14:                    ; DATA XREF: ROM:00054BAC   o  ; was: sub_5505A
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesMedusaHoldCheckSound
                addq.w  #2,4(a5)
Entity_SevenForcesMedusaHoldCheckSound:                 ; CODE XREF: Entity_SevenForcesMedusaHoldState14+4   j  ; was: loc_55064
                cmpi.w  #$38,$48(a5)                    ; '8'
                bne.s   Entity_SevenForcesMedusaHoldApplyPalette
                move.b  #$25,d0                         ; '%'
                jsr     (Sound_QueueSFXRequest).l
Entity_SevenForcesMedusaHoldApplyPalette:               ; CODE XREF: Entity_SevenForcesMedusaHoldState14+10   j  ; was: loc_55076
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesMedusaHoldState14
; State $16: advance Medusa's fade value on alternate frames, then reset
Entity_SevenForcesMedusaFadeOutState16:                 ; DATA XREF: ROM:00054BAE   o  ; was: sub_5507A
                btst    #0,(FrameCounter+1).w
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bmi.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesMedusaFadeOutState16
; State $18: launch the Sylpheed entrance trajectory
Entity_SevenForcesStartSylpheedEntranceState18:         ; DATA XREF: ROM:00054BB0   o  ; was: sub_55094
                move.b  #1,(SceneSequenceFlags).w
                addq.w  #2,4(a5)
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$18000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Entity_SevenForcesUpdateSylpheedEntranceState1A
                neg.l   $18(a5)
; State $1A: apply gravity until Sylpheed reaches the landing threshold
Entity_SevenForcesUpdateSylpheedEntranceState1A:        ; CODE XREF: Entity_SevenForcesStartSylpheedEntranceState18+20   j  ; was: loc_550BA
                                        ; DATA XREF: ROM:00054BB2   o
                addi.l  #$2800,$1C(a5)
                bmi.s   Entity_SevenForcesUpdateSylpheedEntrancePalette
                cmpi.w  #$F0,$14(a5)
                bmi.s   Entity_SevenForcesUpdateSylpheedEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesSylpheedAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesUpdateSylpheedEntrancePalette:        ; CODE XREF: Entity_SevenForcesStartSylpheedEntranceState18+2E   j  ; was: loc_550F0
                                        ; Entity_SevenForcesStartSylpheedEntranceState18+36   j
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesStartSylpheedEntranceState18
; State $1C: hold Sylpheed, play the timed cue, and update its palette
Entity_SevenForcesSylpheedHoldState1C:                  ; DATA XREF: ROM:00054BB4   o  ; was: sub_550F4
                subq.w  #1,$48(a5)
                bpl.s   Entity_SevenForcesSylpheedHoldApplyPalette
                addq.w  #2,4(a5)
                move.b  #$24,d0                         ; '$'
                jsr     (Sound_QueueSFXRequest).l
Entity_SevenForcesSylpheedHoldApplyPalette:             ; CODE XREF: Entity_SevenForcesSylpheedHoldState1C+4   j  ; was: loc_55108
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesSylpheedHoldState1C
; State $1E: wait for the Sylpheed scroll threshold
Entity_SevenForcesWaitForSylpheedScrollState1E:         ; DATA XREF: ROM:00054BB6   o  ; was: sub_5510C
                cmpi.w  #$F760,(PrimaryCameraYPosition).w
                bpl.s   Entity_SevenForcesWaitForSylpheedScrollApplyPalette
                addq.w  #2,4(a5)
Entity_SevenForcesWaitForSylpheedScrollApplyPalette:    ; CODE XREF: Entity_SevenForcesWaitForSylpheedScrollState1E+6   j  ; was: loc_55118
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesWaitForSylpheedScrollState1E
; State $20: advance Sylpheed's fade value on alternate frames, then reset
Entity_SevenForcesSylpheedFadeOutState20:               ; DATA XREF: ROM:00054BB8   o  ; was: sub_5511C
                btst    #0,(FrameCounter+1).w
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bmi.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesSylpheedFadeOutState20
; State $22: configure and launch the Artemis entrance trajectory
Entity_SevenForcesStartArtemisEntranceState22:          ; DATA XREF: ROM:00054BBA   o  ; was: sub_55136
                addq.w  #2,4(a5)
                bclr    #0,(PlayerModeFlags).w
                bclr    #4,(PlayerSpriteAttributes).w
                move.w  #$58,(PlayerStateOffset).w      ; 'X'
                clr.l   (PlayerXVelocity).w
                clr.l   (PlayerYVelocity).w
                move.w  #$34,(PlayerScriptStateOffset).w  ; '4'
                bset    #2,(PlayerRestrictionFlags).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.l  #$38000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Entity_SevenForcesUpdateArtemisEntranceState24
                neg.l   $18(a5)
; State $24: decelerate Artemis upward until it reaches the height threshold
Entity_SevenForcesUpdateArtemisEntranceState24:         ; CODE XREF: Entity_SevenForcesStartArtemisEntranceState22+46   j  ; was: loc_55182
                                        ; DATA XREF: ROM:00054BBC   o
                subi.l  #$1000,(PlayerYVelocity).w
                subi.l  #$2000,$1C(a5)
                bpl.s   Entity_SevenForcesUpdateArtemisEntrancePalette
                cmpi.w  #$100,$14(a5)
                bpl.s   Entity_SevenForcesUpdateArtemisEntrancePalette
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.b  #$A5,d0
                jsr     (Sound_QueueSFXRequest).l
                lea     (SevenForcesArtemisAssetSet).l,a1
                jsr     (Boss_LoadAssetSet).l
Entity_SevenForcesUpdateArtemisEntrancePalette:         ; CODE XREF: Entity_SevenForcesStartArtemisEntranceState22+5C   j  ; was: loc_551BA
                                        ; Entity_SevenForcesStartArtemisEntranceState22+64   j
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesStartArtemisEntranceState22
; State $26: wait for the Artemis completion signal and configure its hold
Entity_SevenForcesWaitForArtemisSignalState26:          ; DATA XREF: ROM:00054BBE   o  ; was: sub_551BE
                subi.l  #$1000,(PlayerYVelocity).w
                tst.b   (SceneSequenceFlags).w
                bne.s   Entity_SevenForcesWaitForArtemisSignalApplyPalette
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$10,$4A(a5)
                clr.w   (PlayerStateOffset).w
                move.w  #$FF84,(PlayerYPosition).w
                move.w  #$D0,(PlayerXPosition).w
                bset    #0,(PlayerObjectFlags).w
Entity_SevenForcesWaitForArtemisSignalApplyPalette:     ; CODE XREF: Entity_SevenForcesWaitForArtemisSignalState26+C   j  ; was: loc_551F2
                bra.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
; End of function Entity_SevenForcesWaitForArtemisSignalState26
; State $28: run Artemis hold timers and fade-out, then reset
Entity_SevenForcesArtemisFadeOutState28:                ; DATA XREF: ROM:00054BC0   o  ; was: sub_551F6
                tst.w   $48(a5)
                bmi.s   Entity_SevenForcesArtemisFadeOutUpdateTimer
                subq.w  #1,$48(a5)
                bpl.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                move.b  #1,(SceneSequenceFlags).w
                bclr    #2,(PlayerRestrictionFlags).w
Entity_SevenForcesArtemisFadeOutUpdateTimer:            ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+4   j  ; was: loc_55210
                subq.w  #1,$4A(a5)
                bne.s   Entity_SevenForcesArtemisFadeOutApplyPalette
                jsr     (Gfx_QueueArtemisIndexedRows).l
                bra.s   Entity_SevenForcesArtemisFadeOutCheckReset
; ---------------------------------------------------------------------------
Entity_SevenForcesArtemisFadeOutApplyPalette:           ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+1E   j  ; was: loc_5521E
                bpl.w   Gfx_UpdateSevenForcesArtemisPaletteFade
Entity_SevenForcesArtemisFadeOutCheckReset:             ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+26   j  ; was: loc_55222
                btst    #0,(FrameCounter+1).w
                beq.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                addq.w  #1,$5E(a5)
                beq.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                bmi.w   Gfx_UpdateSevenForcesArtemisPaletteFade
                bra.w   Entity_SevenForcesResetState
; End of function Entity_SevenForcesArtemisFadeOutState28
