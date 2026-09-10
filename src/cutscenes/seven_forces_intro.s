Entity_SevenForcesMain:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_54B84
                move.w  4(a5),d0
                beq.w   Entity_SevenForcesNoOpState
                movea.w off_54B98(pc,d0.w),a0
                adda.l  #Entity_SevenForcesDispatcher,a0
                jmp     (a0)
; End of function Entity_SevenForcesMain
; ---------------------------------------------------------------------------
off_54B98:      dc.w    Entity_SevenForcesDispatcher-Entity_SevenForcesDispatcher
                                        ; DATA XREF: Entity_SevenForcesMain+8   r
                dc.w    Entity_SevenForcesDispatcher-Entity_SevenForcesDispatcher
                dc.w    Entity_SevenForcesIntroMove-Entity_SevenForcesDispatcher
                dc.w    Entity_SevenForcesTextInit-Entity_SevenForcesDispatcher
                dc.w    Entity_SevenForcesTextUpdate-Entity_SevenForcesDispatcher
                dc.w    Entity_SevenForcesTransform-Entity_SevenForcesDispatcher
                dc.w    Boss_ValkirieMain-Entity_SevenForcesDispatcher
                dc.w    Boss_ValkirieDispatcher-Entity_SevenForcesDispatcher
                dc.w    Boss_MedusaMain-Entity_SevenForcesDispatcher
                dc.w    Boss_Medusa_IntroFallLoop-Entity_SevenForcesDispatcher
                dc.w    Boss_MedusaDispatcher-Entity_SevenForcesDispatcher
                dc.w    Boss_MedusaUpdateSprites-Entity_SevenForcesDispatcher
                dc.w    Boss_SylpheedMain-Entity_SevenForcesDispatcher
                dc.w    Boss_Sylpheed_IntroFallLoop-Entity_SevenForcesDispatcher
                dc.w    Boss_SylpheedDispatcher-Entity_SevenForcesDispatcher
                dc.w    Boss_SylpheedIntroInit-Entity_SevenForcesDispatcher
                dc.w    Boss_SylpheedUpdateSprites-Entity_SevenForcesDispatcher
                dc.w    Boss_ArtemisMain-Entity_SevenForcesDispatcher
                dc.w    Boss_Artemis_IntroRiseLoop-Entity_SevenForcesDispatcher
                dc.w    Boss_SevenForcesWaitIntroComplete-Entity_SevenForcesDispatcher
                dc.w    Boss_ArtemisDispatcher-Entity_SevenForcesDispatcher
                dc.w    Stage_SireneTransition-Entity_SevenForcesDispatcher
                dc.w    Boss_Sirene_IntroFallLoop-Entity_SevenForcesDispatcher
                dc.w    Boss_SireneMain-Entity_SevenForcesDispatcher
                dc.w    Boss_SireneShootPattern3-Entity_SevenForcesDispatcher
                dc.w    Boss_SireneDeathFlash1-Entity_SevenForcesDispatcher
                dc.w    Boss_SireneDeathFlash2-Entity_SevenForcesDispatcher
                dc.w    Cutscene_SevenForcesExplosions-Entity_SevenForcesDispatcher
                dc.w    Cutscene_SevenForcesWaitState-Entity_SevenForcesDispatcher
                dc.w    Cutscene_SevenForcesEffect1-Entity_SevenForcesDispatcher
                dc.w    Cutscene_SevenForcesEffect2-Entity_SevenForcesDispatcher
                dc.w    Cutscene_SevenForcesEffect3-Entity_SevenForcesDispatcher

; Seven Forces dispatcher
Entity_SevenForcesDispatcher:                           ; DATA XREF: Entity_SevenForcesMain+C   o  ; was: sub_54BD8
                                        ; ROM:off_54B98   o
                bra.w   Entity_SevenForcesIntro
; End of function Entity_SevenForcesDispatcher
; Initializes Seven Forces boss encounter with VDP and DMA setup
Boss_SevenForcesInit:
                move.w  #4,4(a5)                        ; was: sub_54BDC
                move.b  #6,(word_FFF7E6+1).w
                move.b  #$8A,(word_FFF7F2+1).w
                move.b  #3,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                move.w  #$58,(word_FFF74A).w            ; 'X'
                clr.w   (word_FFF74E).w
                move.w  #$4000,(dword_FFA940).w
                move.w  #1,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                move.w  #$6000,(dword_FFA940).w
                move.w  #2,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                move.w  #$5000,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                jsr     (VDP_SetupDMA).l
                rts
; End of function Boss_SevenForcesInit
; Seven Forces intro animation
Entity_SevenForcesIntro:                                ; CODE XREF: Entity_SevenForcesDispatcher   j  ; was: sub_54C3C
                move.w  #4,4(a5)
                move.w  #$E900,2(a5)
                move.w  #$2300,$E(a5)
                move.b  #$14,$20(a5)
                move.l  #off_ECE90,8(a5)
                clr.w   $C(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$60,$10(a5)                    ; '`'
                move.w  #$128,$14(a5)
                lea     (byte_C81E).l,a0
                jmp     LoadPalette
; End of function Entity_SevenForcesIntro
; Seven Forces intro movement
Entity_SevenForcesIntroMove:                            ; DATA XREF: ROM:00054B9C   o  ; was: sub_54C7E
                bra.w   Entity_SevenForcesTextDisplay
; End of function Entity_SevenForcesIntroMove
; Debug mode parallax scroll test with directional input and reset
Debug_SevenForcesScrollTest:
                btst    #6,(word_FFF706).w              ; was: sub_54C82
                beq.s   loc_54CEA
                btst    #0,(word_FFF706).w
                beq.s   loc_54CA2
                subi.l  #$800,(dword_FF9404).w
                subi.l  #$400,(dword_FF940C).w
loc_54CA2:                                              ; CODE XREF: Debug_SevenForcesScrollTest+E   j
                btst    #1,(word_FFF706).w
                beq.s   loc_54CBA
                addi.l  #$800,(dword_FF9404).w
                addi.l  #$400,(dword_FF940C).w
loc_54CBA:                                              ; CODE XREF: Debug_SevenForcesScrollTest+26   j
                btst    #3,(word_FFF706).w
                beq.s   loc_54CD2
                addi.l  #$800,(dword_FF9400).w
                addi.l  #$400,(dword_FF9408).w
loc_54CD2:                                              ; CODE XREF: Debug_SevenForcesScrollTest+3E   j
                btst    #2,(word_FFF706).w
                beq.s   loc_54CEA
                subi.l  #$800,(dword_FF9400).w
                subi.l  #$400,(dword_FF9408).w
loc_54CEA:                                              ; CODE XREF: Debug_SevenForcesScrollTest+6   j
                                        ; Debug_SevenForcesScrollTest+56   j
                btst    #4,(word_FFF706).w
                beq.s   loc_54D52
                btst    #0,(word_FFF706).w
                beq.s   loc_54D0A
                subi.l  #$800,(dword_FF9414).w
                subi.l  #$400,(dword_FF941C).w
loc_54D0A:                                              ; CODE XREF: Debug_SevenForcesScrollTest+76   j
                btst    #1,(word_FFF706).w
                beq.s   loc_54D22
                addi.l  #$800,(dword_FF9414).w
                addi.l  #$400,(dword_FF941C).w
loc_54D22:                                              ; CODE XREF: Debug_SevenForcesScrollTest+8E   j
                btst    #3,(word_FFF706).w
                beq.s   loc_54D3A
                addi.l  #$800,(dword_FF9410).w
                addi.l  #$400,(dword_FF9418).w
loc_54D3A:                                              ; CODE XREF: Debug_SevenForcesScrollTest+A6   j
                btst    #2,(word_FFF706).w
                beq.s   loc_54D52
                subi.l  #$800,(dword_FF9410).w
                subi.l  #$400,(dword_FF9418).w
loc_54D52:                                              ; CODE XREF: Debug_SevenForcesScrollTest+6E   j
                                        ; Debug_SevenForcesScrollTest+BE   j
                btst    #5,(word_FFF706).w
                beq.s   loc_54D9A
                clr.l   (dword_FF9400).w
                clr.l   (dword_FF9408).w
                clr.l   (dword_FF9410).w
                clr.l   (dword_FF9418).w
                clr.l   (dword_FF9404).w
                clr.l   (dword_FF940C).w
                clr.l   (dword_FF9414).w
                clr.l   (dword_FF941C).w
                clr.l   (dword_FF9420).w
                clr.l   (dword_FF9428).w
                clr.l   (dword_FF9430).w
                clr.l   (dword_FF9438).w
                clr.l   (dword_FF9424).w
                clr.l   (dword_FF942C).w
                clr.l   (dword_FF9434).w
                clr.l   (dword_FF943C).w
loc_54D9A:                                              ; CODE XREF: Debug_SevenForcesScrollTest+D6   j
                move.l  (dword_FF9400).w,d0
                add.l   d0,(dword_FF9420).w
                move.l  (dword_FF9408).w,d0
                add.l   d0,(dword_FF9428).w
                move.l  (dword_FF9404).w,d0
                add.l   d0,(dword_FF9424).w
                move.l  (dword_FF940C).w,d0
                add.l   d0,(dword_FF942C).w
                move.l  (dword_FF9410).w,d0
                add.l   d0,(dword_FF9430).w
                move.l  (dword_FF9418).w,d0
                add.l   d0,(dword_FF9438).w
                move.l  (dword_FF9414).w,d0
                add.l   d0,(dword_FF9434).w
                move.l  (dword_FF941C).w,d0
                add.l   d0,(dword_FF943C).w
                move.l  (dword_FF9420).w,d3
                move.l  (dword_FF9430).w,d4
                move.l  (dword_FF9424).w,d5
                move.l  (dword_FF9434).w,d6
                btst    #0,(word_FFA000+1).w
                bne.s   loc_54E02
                move.l  (dword_FF9428).w,d3
                move.l  (dword_FF9438).w,d4
                move.l  (dword_FF942C).w,d5
                move.l  (dword_FF943C).w,d6
loc_54E02:                                              ; CODE XREF: Debug_SevenForcesScrollTest+16E   j
                movea.w #(word_FFE400-M68K_RAM),a0
                movea.w #(byte_FFE800-M68K_RAM),a1
                moveq   #$F,d7
                moveq   #0,d1
                moveq   #0,d2
loc_54E10:                                              ; CODE XREF: Debug_SevenForcesScrollTest+1B6   j
                lea     -$20(a1),a1
                swap    d1
                move.w  d1,(a0)
                neg.w   d1
                move.w  d1,(a1)
                neg.w   d1
                swap    d1
                add.l   d3,d1
                swap    d2
                move.w  d2,2(a0)
                neg.w   d2
                move.w  d2,2(a1)
                neg.w   d2
                swap    d2
                add.l   d4,d2
                lea     $20(a0),a0
                dbf     d7,loc_54E10
                movea.w #(word_FFEC00-M68K_RAM),a0
                movea.w #(byte_FFEC50-M68K_RAM),a1
                moveq   #9,d7
                moveq   #0,d1
                moveq   #0,d2
loc_54E4A:                                              ; CODE XREF: Debug_SevenForcesScrollTest+1E4   j
                swap    d1
                swap    d2
                move.w  d1,(a0)+
                move.w  d2,(a0)+
                neg.w   d2
                move.w  d2,-(a1)
                neg.w   d2
                neg.w   d1
                move.w  d1,-(a1)
                neg.w   d1
                swap    d1
                swap    d2
                add.l   d5,d1
                add.l   d6,d2
                dbf     d7,loc_54E4A
                movea.w #(word_FF9600-M68K_RAM),a0
                move.l  #$CCCCCCCC,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  #$CCCCCCCC,d0
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                movea.w #(word_FF9600-M68K_RAM),a0
                move.w  #$20,d0                         ; ' '
                move.w  #$8F02,d3
                move.l  #$94009320,d4
                jsr     (VDP_QueueCommand_Build).l
                move.w  #0,(word_FFE318).w
                btst    #0,(word_FFA000+1).w
                bne.s   loc_54EF2
                move.w  #$FCCC,(word_FF9608).w
                move.w  #$ECCC,(word_FF961A).w
                move.w  #$2CCC,(word_FF9628).w
                move.w  #$1CCC,(word_FF963A).w
                move.w  #$E0,(word_FFE31C).w
                move.w  #$E0,(word_FFE31E).w
                move.w  #$E0,(word_FFE302).w
                move.w  #$E0,(word_FFE304).w
                rts
; ---------------------------------------------------------------------------
loc_54EF2:                                              ; CODE XREF: Debug_SevenForcesScrollTest+23C   j
                move.w  #$CCEC,(dword_FF9610).w
                move.w  #$CCFC,(word_FF9602).w
                move.w  #$CC2C,(word_FF9630).w
                move.w  #$CC1C,(word_FF9622).w
                move.w  #$E0,(word_FFE31C).w
                move.w  #$E0,(word_FFE31E).w
                move.w  #$E0,(word_FFE302).w
                move.w  #$E0,(word_FFE304).w
                rts
; End of function Debug_SevenForcesScrollTest
; Text display handler
Entity_SevenForcesTextDisplay:                          ; CODE XREF: Entity_SevenForcesIntroMove   j  ; was: sub_54F24
                subq.w  #1,$48(a5)
                bpl.s   locret_54F46
                addq.w  #2,4(a5)
                move.l  #$10000,$18(a5)
                bset    #0,(byte_FFA272).w
                jsr     (Stage_TransitionToNextPhase).l
                subq.w  #2,(word_FFA950).w
locret_54F46:                                           ; CODE XREF: Entity_SevenForcesTextDisplay+4   j
                rts
; End of function Entity_SevenForcesTextDisplay
; Text initialization
Entity_SevenForcesTextInit:                             ; DATA XREF: ROM:00054B9E   o  ; was: sub_54F48
                cmpi.w  #$E0,$10(a5)
                bmi.s   locret_54F6A
                addq.w  #2,4(a5)
                move.w  #8,$48(a5)
                move.l  #word_ECEAC,8(a5)
                clr.w   $C(a5)
                clr.l   $18(a5)
locret_54F6A:                                           ; CODE XREF: Entity_SevenForcesTextInit+6   j
                rts
; End of function Entity_SevenForcesTextInit
; Text update handler
Entity_SevenForcesTextUpdate:                           ; DATA XREF: ROM:00054BA0   o  ; was: sub_54F6C
                tst.w   (word_FF80C2).w
                bne.s   locret_54F7C
                subq.w  #1,$48(a5)
                bpl.s   locret_54F7C
                addq.w  #2,4(a5)
locret_54F7C:                                           ; CODE XREF: Entity_SevenForcesTextUpdate+4   j
                                        ; Entity_SevenForcesTextUpdate+A   j
                rts
; End of function Entity_SevenForcesTextUpdate
; Transformation sequence
Entity_SevenForcesTransform:                            ; DATA XREF: ROM:00054BA2   o  ; was: sub_54F7E
                tst.w   (word_FF80C2).w
                bne.s   locret_54F9C
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                clr.w   $5E(a5)
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
locret_54F9C:                                           ; CODE XREF: Entity_SevenForcesTransform+4   j
                rts
; End of function Entity_SevenForcesTransform
; Main boss handler
Boss_ValkirieMain:                                      ; DATA XREF: ROM:00054BA4   o  ; was: sub_54F9E
                subq.w  #1,$48(a5)
                bpl.w   Entity_SevenForcesNoOpState
                addq.w  #1,$5E(a5)
                cmpi.w  #$E,$5E(a5)
                bmi.s   loc_54FE0
                addq.w  #2,4(a5)
                move.w  #$34,$48(a5)                    ; '4'
                clr.w   2(a5)
                move.b  #$96,d0
                jsr     (Sys_WaitVBlank).l
                move.b  #$23,d0                         ; '#'
                jsr     (Sound_PlaySFX).l
                lea     (stru_11658).l,a1
                jsr     (Gfx_UpdateBossPalette).l
loc_54FE0:                                              ; CODE XREF: Boss_ValkirieMain+12   j
                bra.w   Boss_ValkirieIntroInit
; End of function Boss_ValkirieMain
; Boss state dispatcher
Boss_ValkirieDispatcher:                                ; DATA XREF: ROM:00054BA6   o  ; was: sub_54FE4
                subq.w  #1,$48(a5)
                bpl.w   Boss_ValkirieIntroInit
                subq.w  #1,$5E(a5)
                bpl.w   Boss_ValkirieIntroInit
loc_54FF4:                                              ; CODE XREF: Boss_MedusaUpdateSprites+16   j
                                        ; Boss_SylpheedUpdateSprites+16   j
                clr.w   4(a5)
                rts
; End of function Boss_ValkirieDispatcher
; Main boss handler
Boss_MedusaMain:                                        ; DATA XREF: ROM:00054BA8   o  ; was: sub_54FFA
                addq.w  #2,4(a5)
                move.l  #$FFFCC000,$1C(a5)
                move.l  #$12000,$18(a5)
                cmpi.w  #$150,$10(a5)
                bmi.s   Boss_Medusa_IntroFallLoop
                neg.l   $18(a5)
; Seven Forces Medusa intro applies gravity and checks landing
Boss_Medusa_IntroFallLoop:                              ; CODE XREF: Boss_MedusaMain+1A   j  ; was: loc_5501A
                                        ; DATA XREF: ROM:00054BAA   o
                addi.l  #$2800,$1C(a5)
                bmi.s   loc_55056
                cmpi.w  #$F0,$14(a5)
                bmi.s   loc_55056
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                lea     (stru_1166C).l,a1
                jsr     (Gfx_UpdateBossPalette).l
                move.b  #1,(byte_FFA958).w
loc_55056:                                              ; CODE XREF: Boss_MedusaMain+28   j
                                        ; Boss_MedusaMain+30   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_MedusaMain
; Boss state dispatcher
Boss_MedusaDispatcher:                                  ; DATA XREF: ROM:00054BAC   o  ; was: sub_5505A
                subq.w  #1,$48(a5)
                bpl.s   loc_55064
                addq.w  #2,4(a5)
loc_55064:                                              ; CODE XREF: Boss_MedusaDispatcher+4   j
                cmpi.w  #$38,$48(a5)                    ; '8'
                bne.s   loc_55076
                move.b  #$25,d0                         ; '%'
                jsr     (Sound_PlaySFX).l
loc_55076:                                              ; CODE XREF: Boss_MedusaDispatcher+10   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_MedusaDispatcher
; Updates boss sprites
Boss_MedusaUpdateSprites:                               ; DATA XREF: ROM:00054BAE   o  ; was: sub_5507A
                btst    #0,(word_FFA000+1).w
                beq.w   Boss_MedusaIntroInit
                addq.w  #1,$5E(a5)
                beq.w   Boss_MedusaIntroInit
                bmi.w   Boss_MedusaIntroInit
                bra.w   loc_54FF4
; End of function Boss_MedusaUpdateSprites
; Main boss handler
Boss_SylpheedMain:                                      ; DATA XREF: ROM:00054BB0   o  ; was: sub_55094
                move.b  #1,(byte_FFA958).w
                addq.w  #2,4(a5)
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$18000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Boss_Sylpheed_IntroFallLoop
                neg.l   $18(a5)
; Seven Forces Sylpheed intro applies gravity and checks landing
Boss_Sylpheed_IntroFallLoop:                            ; CODE XREF: Boss_SylpheedMain+20   j  ; was: loc_550BA
                                        ; DATA XREF: ROM:00054BB2   o
                addi.l  #$2800,$1C(a5)
                bmi.s   loc_550F0
                cmpi.w  #$F0,$14(a5)
                bmi.s   loc_550F0
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                lea     (stru_1169E).l,a1
                jsr     (Gfx_UpdateBossPalette).l
loc_550F0:                                              ; CODE XREF: Boss_SylpheedMain+2E   j
                                        ; Boss_SylpheedMain+36   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_SylpheedMain
; Boss state dispatcher
Boss_SylpheedDispatcher:                                ; DATA XREF: ROM:00054BB4   o  ; was: sub_550F4
                subq.w  #1,$48(a5)
                bpl.s   loc_55108
                addq.w  #2,4(a5)
                move.b  #$24,d0                         ; '$'
                jsr     (Sound_PlaySFX).l
loc_55108:                                              ; CODE XREF: Boss_SylpheedDispatcher+4   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_SylpheedDispatcher
; Intro animation init
Boss_SylpheedIntroInit:                                 ; DATA XREF: ROM:00054BB6   o  ; was: sub_5510C
                cmpi.w  #$F760,(dword_FFA904).w
                bpl.s   loc_55118
                addq.w  #2,4(a5)
loc_55118:                                              ; CODE XREF: Boss_SylpheedIntroInit+6   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_SylpheedIntroInit
; Updates boss sprites
Boss_SylpheedUpdateSprites:                             ; DATA XREF: ROM:00054BB8   o  ; was: sub_5511C
                btst    #0,(word_FFA000+1).w
                beq.w   Boss_MedusaIntroInit
                addq.w  #1,$5E(a5)
                beq.w   Boss_MedusaIntroInit
                bmi.w   Boss_MedusaIntroInit
                bra.w   loc_54FF4
; End of function Boss_SylpheedUpdateSprites
; Main boss handler
Boss_ArtemisMain:                                       ; DATA XREF: ROM:00054BBA   o  ; was: sub_55136
                addq.w  #2,4(a5)
                bclr    #0,(byte_FF8144).w
                bclr    #4,(word_FFA40E).w
                move.w  #$58,(word_FFA404).w            ; 'X'
                clr.l   (dword_FFA418).w
                clr.l   (dword_FFA41C).w
                move.w  #$34,(word_FFA02A).w            ; '4'
                bset    #2,(byte_FF8245).w
                jsr     (Sys_ClearObjectBlocks17).l
                move.l  #$38000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Boss_Artemis_IntroRiseLoop
                neg.l   $18(a5)
; Seven Forces Artemis intro applies upward momentum
Boss_Artemis_IntroRiseLoop:                             ; CODE XREF: Boss_ArtemisMain+46   j  ; was: loc_55182
                                        ; DATA XREF: ROM:00054BBC   o
                subi.l  #$1000,(dword_FFA41C).w
                subi.l  #$2000,$1C(a5)
                bpl.s   loc_551BA
                cmpi.w  #$100,$14(a5)
                bpl.s   loc_551BA
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                lea     (stru_11680).l,a1
                jsr     (Gfx_UpdateBossPalette).l
loc_551BA:                                              ; CODE XREF: Boss_ArtemisMain+5C   j
                                        ; Boss_ArtemisMain+64   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_ArtemisMain
; Waits for intro animation complete flag, then initializes Medusa phase
Boss_SevenForcesWaitIntroComplete:                      ; DATA XREF: ROM:00054BBE   o  ; was: sub_551BE
                subi.l  #$1000,(dword_FFA41C).w
                tst.b   (byte_FFA958).w
                bne.s   loc_551F2
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                move.w  #$10,$4A(a5)
                clr.w   (word_FFA404).w
                move.w  #$FF84,(dword_FFA414).w
                move.w  #$D0,(dword_FFA410).w
                bset    #0,(word_FFA402).w
loc_551F2:                                              ; CODE XREF: Boss_SevenForcesWaitIntroComplete+C   j
                bra.w   Boss_MedusaIntroInit
; End of function Boss_SevenForcesWaitIntroComplete
; Boss state dispatcher
Boss_ArtemisDispatcher:                                 ; DATA XREF: ROM:00054BC0   o  ; was: sub_551F6
                tst.w   $48(a5)
                bmi.s   loc_55210
                subq.w  #1,$48(a5)
                bpl.w   Boss_ArtemisIntroInit
                move.b  #1,(byte_FFA958).w
                bclr    #2,(byte_FF8245).w
loc_55210:                                              ; CODE XREF: Boss_ArtemisDispatcher+4   j
                subq.w  #1,$4A(a5)
                bne.s   loc_5521E
                jsr     (Gfx_ArtemisPaletteUpdate).l
                bra.s   loc_55222
; ---------------------------------------------------------------------------
loc_5521E:                                              ; CODE XREF: Boss_ArtemisDispatcher+1E   j
                bpl.w   Boss_ArtemisIntroInit
loc_55222:                                              ; CODE XREF: Boss_ArtemisDispatcher+26   j
                btst    #0,(word_FFA000+1).w
                beq.w   Boss_ArtemisIntroInit
                addq.w  #1,$5E(a5)
                beq.w   Boss_ArtemisIntroInit
                bmi.w   Boss_ArtemisIntroInit
                bra.w   loc_54FF4
; End of function Boss_ArtemisDispatcher
; Transition to Sirene form
Stage_SireneTransition:                                 ; DATA XREF: ROM:00054BC2   o  ; was: sub_5523C
                addq.w  #2,4(a5)
                move.w  #$34,(word_FFA02A).w            ; '4'
                move.l  #$FFFC8000,$1C(a5)
                move.l  #$22000,$18(a5)
                cmpi.w  #$120,$10(a5)
                bmi.s   Boss_Sirene_IntroFallLoop
                neg.l   $18(a5)
; Seven Forces Sirene intro applies downward momentum
Boss_Sirene_IntroFallLoop:                              ; CODE XREF: Stage_SireneTransition+20   j  ; was: loc_55262
                                        ; DATA XREF: ROM:00054BC4   o
                addi.l  #$2000,$1C(a5)
                bmi.s   loc_55282
                cmpi.w  #$170,$14(a5)
                bmi.s   loc_55282
                addq.w  #2,4(a5)
                clr.w   2(a5)
                move.w  #$40,$48(a5)                    ; '@'
loc_55282:                                              ; CODE XREF: Stage_SireneTransition+2E   j
                                        ; Stage_SireneTransition+36   j
                bra.w   Boss_ArtemisIntroInit
; End of function Stage_SireneTransition
; Main boss handler
Boss_SireneMain:                                        ; DATA XREF: ROM:00054BC6   o  ; was: sub_55286
                subq.w  #1,$48(a5)
                bpl.s   loc_552AC
                addq.w  #2,4(a5)
                move.w  #$20,$48(a5)                    ; ' '
                move.b  #$28,d0                         ; '('
                jsr     (Sound_PlaySFX).l
                lea     (stru_11676).l,a1
                jsr     (Gfx_UpdateBossPalette).l
loc_552AC:                                              ; CODE XREF: Boss_SireneMain+4   j
                addq.w  #1,$5E(a5)
                beq.w   Boss_ArtemisIntroInit
                bmi.w   Boss_ArtemisIntroInit
                rts
; End of function Boss_SireneMain
; Attributes: thunk
; Shooting pattern 3
Boss_SireneShootPattern3:                               ; DATA XREF: ROM:00054BC8   o  ; was: sub_552BA
                bra.w   loc_54FF4
; End of function Boss_SireneShootPattern3
; Plays death sound effects and updates palette at frame $9C
Boss_SireneDeathFlash1:                                 ; DATA XREF: ROM:00054BCA   o  ; was: sub_552BE
                cmpi.w  #$9C,(word_FFA950).w
                bne.s   locret_552EA
                move.b  #$27,d0                         ; '''
                jsr     (Sound_PlaySFX).l
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                lea     (stru_11694).l,a1
                jsr     (Gfx_UpdateBossPalette).l
                bra.w   loc_54FF4
; ---------------------------------------------------------------------------
locret_552EA:                                           ; CODE XREF: Boss_SireneDeathFlash1+6   j
                rts
; End of function Boss_SireneDeathFlash1
; Plays death sound effects and updates palette at frame $A6
Boss_SireneDeathFlash2:                                 ; DATA XREF: ROM:00054BCC   o  ; was: sub_552EC
                cmpi.w  #$A6,(word_FFA950).w
                bne.s   locret_55318
                move.b  #$26,d0                         ; '&'
                jsr     (Sound_PlaySFX).l
                move.b  #$A5,d0
                jsr     (Sound_PlaySFX).l
                lea     (stru_1168A).l,a1
                jsr     (Gfx_UpdateBossPalette).l
                bra.w   loc_54FF4
; ---------------------------------------------------------------------------
locret_55318:                                           ; CODE XREF: Boss_SireneDeathFlash2+6   j
                rts
; End of function Boss_SireneDeathFlash2
; Spawns explosion effects
Cutscene_SevenForcesExplosions:                         ; DATA XREF: ROM:00054BCE   o  ; was: sub_5531A
                addq.w  #1,$48(a5)
                cmpi.w  #2,$48(a5)
                bne.s   loc_55330
                move.b  #3,d0
                jsr     (Sound_PlaySFX).l
loc_55330:                                              ; CODE XREF: Cutscene_SevenForcesExplosions+A   j
                bsr.w   Boss_ArtemisIntroInit
                cmpi.w  #$98,(word_FFA950).w
                bne.s   loc_55352
                addq.w  #2,4(a5)
                move.w  #$200,$48(a5)
                move.b  #1,(byte_FF830E).w
                move.w  #$C0,(word_FF809E).w
loc_55352:                                              ; CODE XREF: Cutscene_SevenForcesExplosions+20   j
                                        ; sub_553CC:loc_553DC   p
                move.w  #2,(word_FFA010).w
                move.w  #2,(word_FFA014).w
                jsr     (Projectile_UpdateWithExplosionSound).l
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_553CA
                jsr     (Sprite_InitType160).l
                move.l  #off_E953C,8(a0)
                btst    #0,(dword_FFFF08).w
                beq.s   loc_5538A
                move.l  #off_E9560,8(a0)
loc_5538A:                                              ; CODE XREF: Cutscene_SevenForcesExplosions+66   j
                move.b  #0,$20(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                asl.w   #1,d0
                addi.l  #$80000,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$FF,d0
                andi.w  #$FF,d1
                subi.w  #$80,d0
                subi.w  #$80,d1
                addi.w  #$120,d0
                addi.w  #$F0,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
locret_553CA:                                           ; CODE XREF: Cutscene_SevenForcesExplosions+50   j
                rts
; End of function Cutscene_SevenForcesExplosions
; Wait state with timer
Cutscene_SevenForcesWaitState:                          ; DATA XREF: ROM:00054BD0   o  ; was: sub_553CC
                subq.w  #1,$48(a5)
                bpl.s   loc_553DC
                addq.w  #2,4(a5)
                move.b  #1,(byte_FFA958).w
loc_553DC:                                              ; CODE XREF: Cutscene_SevenForcesWaitState+4   j
                bsr.w   loc_55352
                addq.w  #1,$5E(a5)
                beq.w   Boss_ArtemisIntroInit
                bmi.w   Boss_ArtemisIntroInit
                rts
; End of function Cutscene_SevenForcesWaitState
; Visual effect handler 1
Cutscene_SevenForcesEffect1:                            ; DATA XREF: ROM:00054BD2   o  ; was: sub_553EE
                cmpi.w  #$A2,(word_FFA950).w
                bne.s   locret_5540A
                addq.w  #2,4(a5)
                clr.w   $5E(a5)
                move.w  #$2E,(word_FF80C2).w            ; '.'
                move.b  #1,(byte_FF80FA).w
locret_5540A:                                           ; CODE XREF: Cutscene_SevenForcesEffect1+6   j
                rts
; End of function Cutscene_SevenForcesEffect1
; Visual effect handler 2
Cutscene_SevenForcesEffect2:                            ; DATA XREF: ROM:00054BD4   o  ; was: sub_5540C
                bsr.w   Cutscene_SevenForcesEffect4
                subq.w  #1,$5E(a5)
                cmpi.w  #$FFF2,$5E(a5)
                bpl.s   loc_55426
                addq.w  #2,4(a5)
                move.w  #$210,$48(a5)
loc_55426:                                              ; CODE XREF: Cutscene_SevenForcesEffect2+E   j
                move.w  $5E(a5),d0
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$1F,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Cutscene_SevenForcesEffect2
; Visual effect handler 3
Cutscene_SevenForcesEffect3:                            ; DATA XREF: ROM:00054BD6   o  ; was: sub_5543A
                bsr.w   Cutscene_SevenForcesEffect4
                subq.w  #1,$48(a5)
                bpl.s   locret_5545E
                tst.w   (word_FF8230).w
                bne.s   locret_5545E
                move.b  #$93,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                jmp     Stage_InitTransitionState
; ---------------------------------------------------------------------------
locret_5545E:                                           ; CODE XREF: Cutscene_SevenForcesEffect3+8   j
                                        ; Cutscene_SevenForcesEffect3+E   j
                rts
; End of function Cutscene_SevenForcesEffect3
; Intro animation init
Boss_ValkirieIntroInit:                                 ; CODE XREF: Boss_ValkirieMain:loc_54FE0   j  ; was: sub_55460
                                        ; Boss_ValkirieDispatcher+4   j
                move.w  $5E(a5),d0
                movea.w #(word_FFE300-M68K_RAM),a0
                moveq   #$3F,d5                         ; '?'
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(word_FFE364).w
                rts
; End of function Boss_ValkirieIntroInit
; Intro animation init
Boss_MedusaIntroInit:                                   ; CODE XREF: Boss_MedusaMain:loc_55056   j  ; was: sub_5547C
                                        ; sub_5505A:loc_55076   j
                movea.w #(word_FFE320-M68K_RAM),a0
                moveq   #$F,d5
                move.w  $5E(a5),d0
                neg.w   d0
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                movea.w #(word_FFE342-M68K_RAM),a0
                moveq   #$1B,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(word_FFE364).w
                move.w  $5E(a5),d0
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_MedusaIntroInit
; Intro animation init
Boss_ArtemisIntroInit:                                  ; CODE XREF: Boss_ArtemisDispatcher+A   j  ; was: sub_554C0
                                        ; sub_551F6:loc_5521E   j
                move.w  $5E(a5),d0
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                movea.w #(word_FFE32A-M68K_RAM),a0
                moveq   #7,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  $5E(a5),d0
                neg.w   d0
                movea.w #(word_FFE320-M68K_RAM),a0
                moveq   #4,d5
                move.w  #$E000,d7
                jsr     (Gfx_ApplyPaletteFade).l
                move.w  #$EEE,(word_FFE364).w
                move.w  $5E(a5),d0
                movea.w #(word_FFE342-M68K_RAM),a0
                moveq   #$1B,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function Boss_ArtemisIntroInit
; Intro movement
Boss_MedusaIntroMove:                                   ; CODE XREF: Boss_MedusaIdleState+6   p  ; was: sub_55518
                                        ; Boss_SylpheedIntroMove+6   p
                move.b  #$14,$20(a5)
                clr.w   $C(a5)
                move.w  #$CD00,2(a5)
                move.l  #word_ECDCA,8(a5)
                move.w  #$6300,$E(a5)
                move.w  (dword_FFC630).w,$10(a5)
                move.w  (dword_FFC634).w,$14(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                rts
; End of function Boss_MedusaIntroMove
; Visual effect handler 4
Cutscene_SevenForcesEffect4:                            ; CODE XREF: Cutscene_SevenForcesEffect2   p  ; was: sub_5554C
                                        ; sub_5543A   p
                jsr     (Projectile_FindFreeSlot).l
                bne.s   locret_555C6
                move.w  #$188,(a0)
                move.w  #$8400,2(a0)
                move.w  #$10,$48(a0)
                moveq   #0,d0
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                addq.w  #8,d0
                swap    d0
                asr.l   #2,d0
                move.l  d0,$1C(a0)
                move.l  d0,$18(a0)
                move.b  #$70,$20(a0)                    ; 'p'
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$FF,d0
                andi.w  #$7F,d1
                subi.w  #$80,d0
                addi.w  #$120,d0
                addi.w  #$A0,d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  #$44F4,$E(a0)
                btst    #0,(dword_FFFF08).w
                bne.s   loc_555BA
                move.w  #$44F5,$E(a0)
loc_555BA:                                              ; CODE XREF: Cutscene_SevenForcesEffect4+66   j
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
locret_555C6:                                           ; CODE XREF: Cutscene_SevenForcesEffect4+6   j
                rts
; End of function Cutscene_SevenForcesEffect4
; Intro stop position
Boss_MedusaIntroStop:                                   ; CODE XREF: Boss_ValkirieIntroMove+26   j  ; was: sub_555C8
                                        ; Boss_MedusaAttackState1+26   j
                bset    #0,(byte_FFA272).w
                movea.w #(word_FFDC40-M68K_RAM),a5
                bsr.s   Boss_MedusaBattleStart
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                rts
; End of function Boss_MedusaIntroStop
; Battle start initialization
Boss_MedusaBattleStart:                                 ; CODE XREF: Boss_MedusaIntroStop+A   p  ; was: sub_555DA
                movea.w off_555E6(pc,d0.w),a1
                adda.l  #Boss_MedusaResetState,a1
                jmp     (a1)
; End of function Boss_MedusaBattleStart
; ---------------------------------------------------------------------------
off_555E6:      dc.w    Boss_MedusaResetState-Boss_MedusaResetState
                                        ; DATA XREF: Boss_MedusaBattleStart   r
                dc.w    Boss_MedusaIdleState-Boss_MedusaResetState
                dc.w    Boss_SylpheedIntroMove-Boss_MedusaResetState
                dc.w    Boss_ArtemisIntroMove-Boss_MedusaResetState
                dc.w    Boss_SireneDispatcher-Boss_MedusaResetState
                dc.w    Boss_SireneEndBattle1-Boss_MedusaResetState
                dc.w    Boss_SireneEndBattle2-Boss_MedusaResetState
                dc.w    Cutscene_SevenForcesTransition-Boss_MedusaResetState
                dc.w    Cutscene_SevenForcesEmptyTransition-Boss_MedusaResetState

; Resets boss state word at offset 4 to 0, called from Medusa battle start
Boss_MedusaResetState:                                  ; DATA XREF: Boss_MedusaBattleStart+4   o  ; was: sub_555F8
                                        ; ROM:off_555E6   o
                move.w  #0,4(a5)
                rts
; End of function Boss_MedusaResetState
; Idle state handler
Boss_MedusaIdleState:                                   ; DATA XREF: ROM:000555E8   o  ; was: sub_55600
                move.w  #$10,4(a5)
                bsr.w   Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$FFF4,$5E(a5)
                bsr.w   Boss_MedusaIntroInit
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_PlaySFX).l
; End of function Boss_MedusaIdleState
; Intro movement
Boss_SylpheedIntroMove:                                 ; DATA XREF: ROM:000555EA   o  ; was: sub_5562A
                move.w  #$18,4(a5)
                bsr.w   Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                lea     (byte_C00C).l,a0
                jsr     (LoadPalette).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Boss_MedusaIntroInit
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_PlaySFX).l
; End of function Boss_SylpheedIntroMove
; Intro movement
Boss_ArtemisIntroMove:                                  ; DATA XREF: ROM:000555EC   o  ; was: sub_5566C
                move.b  #1,(byte_FFA958).w
                move.w  #$22,4(a5)                      ; '"'
                bsr.w   Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                lea     (byte_C01C).l,a0
                jsr     (LoadPalette).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Boss_MedusaIntroInit
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_PlaySFX).l
; End of function Boss_ArtemisIntroMove
; Boss state dispatcher
Boss_SireneDispatcher:                                  ; DATA XREF: ROM:000555EE   o  ; was: sub_556A8
                move.w  #$2A,4(a5)                      ; '*'
                bsr.w   Boss_MedusaIntroMove
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Boss_MedusaIntroInit
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_PlaySFX).l
; End of function Boss_SireneDispatcher
; Sets state to $24, flags transition, clears sprites except $428, plays sound $30
Boss_SireneEndBattle1:                                  ; DATA XREF: ROM:000555F0   o  ; was: sub_556D2
                move.w  #$24,4(a5)                      ; '$'
                move.b  #1,(byte_FFA958).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_PlaySFX).l
; End of function Boss_SireneEndBattle1
; Sets state to $26, flags transition, clears sprites except $428, plays sound $30
Boss_SireneEndBattle2:                                  ; DATA XREF: ROM:000555F2   o  ; was: sub_556F4
                move.w  #$26,4(a5)                      ; '&'
                move.b  #1,(byte_FFA958).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_PlaySFX).l
; End of function Boss_SireneEndBattle2
; Transition after victory
Cutscene_SevenForcesTransition:                         ; DATA XREF: ROM:000555F4   o  ; was: sub_55716
                move.w  #$36,4(a5)                      ; '6'
                bclr    #0,(word_FFA402).w
                bset    #0,(byte_FF8144).w
                bclr    #2,(byte_FF8144).w
                clr.w   $48(a5)
                clr.b   (word_FFF7E6+1).w
                clr.b   (byte_FFA95A).w
                clr.b   (byte_FFA95B).w
                move.b  #1,(byte_FFA958).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Boss_MedusaIntroInit
                rts
; End of function Cutscene_SevenForcesTransition
; Empty Seven Forces cutscene transition
Cutscene_SevenForcesEmptyTransition:                    ; DATA XREF: ROM:000555F6   o  ; was: nullsub_127
                rts
; End of function Cutscene_SevenForcesEmptyTransition
; Intro movement
