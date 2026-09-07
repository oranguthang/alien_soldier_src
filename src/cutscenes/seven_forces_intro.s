Entity_SevenForcesMain:                                 ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_54B84
                move.w  4(a5),d0
                beq.w   nullsub_126
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
