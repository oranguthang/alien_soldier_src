; Main Z-Leo boss handler
Boss_ZLeoMain:                                          ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_51AD6
                tst.w   4(a5)
                beq.w   loc_51B6A
                tst.w   8(a5)
                beq.w   loc_51B6A
                btst    #2,(byte_FF80EC).w
                bne.s   loc_51AFE
                btst    #1,(byte_FF80EC).w
                bne.s   loc_51AFE
                tst.w   (word_FF8200).w
                beq.w   Boss_ZLeoAttackPattern2
loc_51AFE:                                              ; CODE XREF: Boss_ZLeoMain+16   j
                                        ; Boss_ZLeoMain+1E   j
                move.w  $4DC(a5),d0
                beq.s   loc_51B20
                bpl.s   loc_51B0A
                addq.w  #1,d0
                bra.s   loc_51B0C
; ---------------------------------------------------------------------------
loc_51B0A:                                              ; CODE XREF: Boss_ZLeoMain+2E   j
                subq.w  #1,d0
loc_51B0C:                                              ; CODE XREF: Boss_ZLeoMain+32   j
                move.w  d0,$4DC(a5)
                movea.w #(word_FFE302-M68K_RAM),a0
                moveq   #$E,d5
                move.w  $4DE(a5),d7
                jsr     (Gfx_ApplyPaletteFade).l
loc_51B20:                                              ; CODE XREF: Boss_ZLeoMain+2C   j
                move.w  $53C(a5),d0
                beq.s   loc_51B42
                bpl.s   loc_51B2C
                addq.w  #1,d0
                bra.s   loc_51B2E
; ---------------------------------------------------------------------------
loc_51B2C:                                              ; CODE XREF: Boss_ZLeoMain+50   j
                subq.w  #1,d0
loc_51B2E:                                              ; CODE XREF: Boss_ZLeoMain+54   j
                move.w  d0,$53C(a5)
                movea.w #(byte_FFE322-M68K_RAM),a0
                moveq   #$1E,d5
                move.w  $53E(a5),d7
                jsr     (Gfx_ApplyPaletteFade).l
loc_51B42:                                              ; CODE XREF: Boss_ZLeoMain+4E   j
                move.w  $59C(a5),d0
                beq.s   loc_51B64
                bpl.s   loc_51B4E
                addq.w  #1,d0
                bra.s   loc_51B50
; ---------------------------------------------------------------------------
loc_51B4E:                                              ; CODE XREF: Boss_ZLeoMain+72   j
                subq.w  #1,d0
loc_51B50:                                              ; CODE XREF: Boss_ZLeoMain+76   j
                move.w  d0,$59C(a5)
                movea.w #(word_FFE362-M68K_RAM),a0
                moveq   #$E,d5
                move.w  $59E(a5),d7
                jsr     (Gfx_ApplyPaletteFade).l
loc_51B64:                                              ; CODE XREF: Boss_ZLeoMain+70   j
                jsr     (Gfx_InitPaletteFade).l
loc_51B6A:                                              ; CODE XREF: Boss_ZLeoMain+4   j
                                        ; Boss_ZLeoMain+C   j
                bsr.s   Boss_ZLeoDispatcher
                clr.w   (word_FF9500).w
                rts
; End of function Boss_ZLeoMain
; Boss state dispatcher
Boss_ZLeoDispatcher:                                    ; CODE XREF: Boss_ZLeoMain:loc_51B6A   p  ; was: sub_51B72
                move.w  4(a5),d0
                movea.w off_51B82(pc,d0.w),a0
                adda.l  #nullsub_120,a0
                jmp     (a0)
; End of function Boss_ZLeoDispatcher
; ---------------------------------------------------------------------------
off_51B82:      dc.w    Boss_ZLeoInit-nullsub_120
                                        ; DATA XREF: Boss_ZLeoDispatcher+4   r
                dc.w    Boss_ZLeoIntroInit-nullsub_120
                dc.w    Boss_ZLeoAttack_State8-nullsub_120
                dc.w    Boss_ZLeoAttack_State10-nullsub_120
                dc.w    Boss_ZLeoAttack_State12-nullsub_120
                dc.w    Boss_ZLeoDefeatedFadeout-nullsub_120
                dc.w    Boss_ZLeoDefeatedDelay-nullsub_120
                dc.w    Boss_ZLeoEmptyState-nullsub_120
                dc.w    Boss_ZLeoIntroMove-nullsub_120
                dc.w    Boss_ZLeoBattleStart-nullsub_120
                dc.w    Boss_ZLeoAttack_State14-nullsub_120
                dc.w    Boss_ZLeoBattleState1-nullsub_120
                dc.w    Boss_ZLeoBattleState2-nullsub_120
                dc.w    Boss_ZLeoAttack_State20-nullsub_120
                dc.w    Boss_ZLeoDefeatCheck-nullsub_120
                dc.w    Boss_ZLeo_AttackPattern1_WaitLoop-nullsub_120
                dc.w    Boss_ZLeoAttackState1-nullsub_120
                dc.w    Boss_ZLeoAttack_State28-nullsub_120
                dc.w    Boss_ZLeoAttack_State30-nullsub_120
                dc.w    Boss_ZLeoAttack_State32-nullsub_120
                dc.w    Boss_ZLeoAttackSequence-nullsub_120
                dc.w    Boss_ZLeoAttack_State38-nullsub_120
                dc.w    Boss_ZLeoAttack_State40-nullsub_120
                dc.w    Boss_ZLeoAttack_State42-nullsub_120
                dc.w    Boss_ZLeoAttack_State44-nullsub_120
                dc.w    Boss_ZLeoAttack_State46-nullsub_120
                dc.w    Boss_ZLeoAttack_State48-nullsub_120
                dc.w    Boss_ZLeoAttack_State50-nullsub_120
                dc.w    Boss_ZLeoAttack_State36-nullsub_120

nullsub_120:                                            ; CODE XREF: Boss_ZLeoIntroInit+E   j
                                        ; Boss_ZLeoTileUpdate+16   j
                rts
; End of function nullsub_120

; Boss initialization
Boss_ZLeoInit:                                          ; DATA XREF: ROM:off_51B82   o  ; was: sub_51BBE
                tst.w   (word_FF80C2).w
                bne.w   locret_51C30
                addq.w  #2,4(a5)
                bset    #0,(byte_FF8245).w
                move.w  #$3F8,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.w  #$54,(word_FFF74A).w            ; 'T'
                clr.w   (word_FFF74E).w
                move.w  #$18,(word_FF8090).w
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                movea.l #$FFFF4520,a0
                move.w  #$A000,d0
                moveq   #5,d7
                jsr     (Gfx_AdjustTileIndices).l
                bsr.w   Boss_ZLeoGraphicsInit1
                bsr.w   Boss_ZLeoGraphicsInit2
                bsr.w   Boss_ZLeoGraphicsInit3
                move.l  #dword_11316,(dword_FFA940).w
                move.w  #0,(word_FFA946).w
                move.w  #$F600,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
locret_51C30:                                           ; CODE XREF: Boss_ZLeoInit+4   j
                rts
; End of function Boss_ZLeoInit
; Intro sequence init
Boss_ZLeoIntroInit:                                     ; DATA XREF: ROM:00051B84   o  ; was: sub_51C32
                bsr.w   Boss_ZLeoGraphicsInit2
                jsr     (Gfx_RenderScrollingBackground).l
                tst.w   (word_FFA944).w
                bpl.w   nullsub_120
                move.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$380,(dword_FF8040).w
                moveq   #$F,d7
                movea.l #Boss_ZLeoValkirieForceSharedMetaspriteData,a0
                movea.l #Boss_ZLeoPartRadii,a1
                movea.l #Boss_ZLeoPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                move.w  #$3F8,(a5)
                move.w  #$C00,2(a5)
                movea.l #$FFFF2020,a0
                move.w  #$6000,d0
                move.w  #$280,d1
                moveq   #$1F,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                movea.l #$FFFF2080,a0
                move.w  #$E000,d0
                moveq   #3,d7
                jsr     (Gfx_AdjustTileIndices).l
                move.w  #$7FFF,d0
                lea     (byte_FF2080).l,a0
                and.w   d0,(a0)
                and.w   d0,2(a0)
                and.w   d0,8(a0)
                and.w   d0,$A(a0)
                and.w   d0,$10(a0)
                and.w   d0,$12(a0)
                and.w   d0,$18(a0)
                and.w   d0,$1A(a0)
                lea     (word_FF20E0).l,a0
                and.w   d0,word_FF20E4-word_FF20E0(a0)
                and.w   d0,6(a0)
                and.w   d0,$C(a0)
                and.w   d0,$E(a0)
                and.w   d0,$14(a0)
                and.w   d0,$16(a0)
                and.w   d0,$1C(a0)
                and.w   d0,$1E(a0)
                clr.w   (word_FF9600).w
                clr.w   (dword_FFA900).w
                move.w  #$100,(dword_FFA904).w
                move.w  #$100,(word_FF9602).w
                bset    #7,(byte_FFA959).w
                bset    #6,(byte_FFA959).w
                move.w  #$10,d0
                move.w  #$C000,d1
                move.w  #$4B80,d2
                movea.w #(word_FFCDA0-M68K_RAM),a0
                moveq   #2,d7
loc_51D1E:                                              ; CODE XREF: Boss_ZLeoIntroInit+110   j
                moveq   #$10,d3
                moveq   #2,d6
loc_51D22:                                              ; CODE XREF: Boss_ZLeoIntroInit+10C   j
                move.w  d0,(a0)
                move.w  d1,2(a0)
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                subq.w  #4,d3
                move.l  #word_ED3B8,8(a0)
                lea     $60(a0),a0
                dbf     d6,loc_51D22
                dbf     d7,loc_51D1E
                move.l  #word_ED3BE,d4
                move.l  d4,$848(a5)
                move.l  d4,$968(a5)
                move.l  d4,$A88(a5)
                movea.w #(byte_FFD100-M68K_RAM),a0
                moveq   #$50,d3                         ; 'P'
                moveq   #5,d7
loc_51D60:                                              ; CODE XREF: Boss_ZLeoIntroInit+140   j
                move.w  d0,(a0)
                move.w  d1,2(a0)
                move.w  d2,$E(a0)
                move.b  d3,$20(a0)
                lea     $60(a0),a0
                dbf     d7,loc_51D60
                move.l  #word_ED478,$AE8(a5)
                move.l  #word_ED39A,$B48(a5)
                move.l  #word_ED394,$BA8(a5)
                move.l  #word_ED478,$C08(a5)
                move.l  #word_ED39A,$C68(a5)
                move.l  #word_ED394,$CC8(a5)
                bclr    #3,$AEE(a5)
                bclr    #3,$B4E(a5)
                bclr    #3,$BAE(a5)
                move.b  #$4C,$B60(a5)                   ; 'L'
                move.b  #$4C,$C80(a5)                   ; 'L'
                movea.l #Boss_ZLeoObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                clr.l   $2FC(a5)
                clr.l   $35C(a5)
                move.w  #2,$1DE(a5)
                bra.w   loc_51E82
; End of function Boss_ZLeoIntroInit
; Initializes Z-Leo boss intro sequence - sets position ($120,$1A0), clears state, animates Y position down to $E8
Boss_ZLeoIntroSetup:
                move.w  #$120,$2FC(a5)                  ; was: sub_51DE2
                move.w  #$1A0,$35C(a5)
                move.w  #4,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
; Z-Leo boss movement state
Boss_ZLeoAttack_State8:                                 ; DATA XREF: ROM:00051B86   o  ; was: loc_51E0E
                subq.w  #1,$35C(a5)
                cmpi.w  #$E8,$35C(a5)
                bpl.s   loc_51E24
                move.w  #$E8,$35C(a5)
                clr.b   (byte_FF80EC).w
loc_51E24:                                              ; CODE XREF: Boss_ZLeoIntroSetup+36   j
                move.w  $5B4(a5),d0
                addi.w  #0,d0
                move.w  d0,(dword_FFDB34).w
                lea     word_52C56(pc),a1
                nop
                bra.w   loc_5262E
; End of function Boss_ZLeoIntroSetup
; Debug controller handler for Z-Leo - allows manual position and angle adjustments via controller buttons
Boss_ZLeoDebugControl:
                btst    #2,(word_FFF706).w              ; was: sub_51E3A
                beq.s   loc_51E46
                subq.w  #3,$10(a5)
loc_51E46:                                              ; CODE XREF: Boss_ZLeoDebugControl+6   j
                btst    #3,(word_FFF706).w
                beq.s   loc_51E52
                addq.w  #3,$10(a5)
loc_51E52:                                              ; CODE XREF: Boss_ZLeoDebugControl+12   j
                btst    #0,(word_FFF706).w
                beq.s   loc_51E5E
                subq.w  #2,$14(a5)
loc_51E5E:                                              ; CODE XREF: Boss_ZLeoDebugControl+1E   j
                btst    #1,(word_FFF706).w
                beq.s   loc_51E6A
                addq.w  #2,$14(a5)
loc_51E6A:                                              ; CODE XREF: Boss_ZLeoDebugControl+2A   j
                btst    #6,(word_FFF706).w
                beq.s   loc_51E76
                addq.w  #2,(dword_FFDB34).w
loc_51E76:                                              ; CODE XREF: Boss_ZLeoDebugControl+36   j
                btst    #4,(word_FFF706).w
                beq.s   loc_51E82
                subq.w  #2,(dword_FFDB34).w
loc_51E82:                                              ; CODE XREF: Boss_ZLeoIntroInit+1AC   j
                                        ; Boss_ZLeoDebugControl+42   j
                move.w  #$10,4(a5)
                move.w  #$1C0,$11C(a5)
                move.w  #$120,$2FC(a5)
                move.w  #$1E0,$35C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  a5,$48(a5)
                move.w  a5,$4A(a5)
                move.b  #$95,d0
                jsr     (Sys_WaitVBlank).l
; End of function Boss_ZLeoDebugControl
; Intro movement sequence
Boss_ZLeoIntroMove:                                     ; DATA XREF: ROM:00051B92   o  ; was: sub_51EB6
                cmpi.w  #$1B8,$11C(a5)
                bne.s   loc_51EC8
                move.b  #$F7,d0
                jsr     (Sound_PlaySFX).l
loc_51EC8:                                              ; CODE XREF: Boss_ZLeoIntroMove+6   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_51EDE
                move.w  #2,(word_FFA014).w
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_51EDE:                                              ; CODE XREF: Boss_ZLeoIntroMove+16   j
                addq.w  #2,4(a5)
                move.w  #$E000,$59E(a5)
                move.w  #$FFF6,$11C(a5)
                clr.w   $11E(a5)
                lea     stru_51F50(pc),a0
                nop
                jsr     (Data_ProcessPointer).l
; End of function Boss_ZLeoIntroMove
; Battle start handler
Boss_ZLeoBattleStart:                                   ; DATA XREF: ROM:00051B94   o  ; was: sub_51EFE
                subi.l  #$8000,$35C(a5)
                cmpi.w  #$F0,$35C(a5)
                bmi.s   loc_51F5A
                tst.w   $11E(a5)
                bne.s   loc_51F20
                cmpi.w  #$144,$35C(a5)
                bpl.s   loc_51F34
                addq.w  #1,$11E(a5)
loc_51F20:                                              ; CODE XREF: Boss_ZLeoBattleStart+14   j
                move.w  (word_FFA000).w,d0
                andi.w  #7,d0
                bne.s   loc_51F34
                addq.w  #1,$11C(a5)
                bmi.s   loc_51F34
                clr.w   $11C(a5)
loc_51F34:                                              ; CODE XREF: Boss_ZLeoBattleStart+1C   j
                                        ; Boss_ZLeoBattleStart+2A   j
                move.w  $11C(a5),$59C(a5)
                move.w  #3,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
stru_51F50:     dc.w    6                               ; field_0
                                        ; DATA XREF: Boss_ZLeoIntroMove+3C   o
                dc.l    byte_1C8CB4                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    $FFFF
; ---------------------------------------------------------------------------
loc_51F5A:                                              ; CODE XREF: Boss_ZLeoBattleStart+E   j
                addq.w  #2,4(a5)
                move.w  #$F0,$35C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.w  #4,(word_FFA010).w
                move.w  #3,(word_FFA014).w
; Z-Leo boss attack pattern
Boss_ZLeoAttack_State14:                                ; DATA XREF: ROM:00051B96   o  ; was: loc_51F76
                subq.w  #1,$11C(a5)
                bmi.s   loc_51F86
                lea     word_52C7A(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_51F86:                                              ; CODE XREF: Boss_ZLeoBattleStart+7C   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$20,$11C(a5)                   ; ' '
                move.w  #4,(word_FFA010).w
                move.w  #3,(word_FFA014).w
                bsr.w   Boss_ZLeoAnimationUpdate1
; End of function Boss_ZLeoBattleStart
; Battle state 1 handler
Boss_ZLeoBattleState1:                                  ; DATA XREF: ROM:00051B98   o  ; was: sub_51FAA
                tst.w   $58(a5)
                bmi.s   loc_51FC6
                bclr    #0,$23E(a5)
                beq.s   loc_51FBC
                bsr.w   Boss_ZLeoEnableParts
loc_51FBC:                                              ; CODE XREF: Boss_ZLeoBattleState1+C   j
                lea     word_52C8C(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_51FC6:                                              ; CODE XREF: Boss_ZLeoBattleState1+4   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$60,$11C(a5)                   ; '`'
                bsr.w   Boss_ZLeoLoadDefeatTiles
                move.b  #$EC,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoBattleState1
; Battle state 2 handler
Boss_ZLeoBattleState2:                                  ; DATA XREF: ROM:00051B9A   o  ; was: sub_51FE8
                subq.w  #1,$11C(a5)
                bmi.s   loc_51FF8
                lea     word_52C9C(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_51FF8:                                              ; CODE XREF: Boss_ZLeoBattleState2+4   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$40,$11C(a5)                   ; '@'
; Z-Leo boss combo phase
Boss_ZLeoAttack_State20:                                ; DATA XREF: ROM:00051B9C   o  ; was: loc_5200C
                subq.w  #1,$11C(a5)
                bmi.s   loc_5201C
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5201C:                                              ; CODE XREF: Boss_ZLeoBattleState2+28   j
                addq.w  #2,4(a5)
                moveq   #0,d0
                jsr     (UI_CheckVictoryCondition).l
; End of function Boss_ZLeoBattleState2
; Check defeat condition
Boss_ZLeoDefeatCheck:                                   ; DATA XREF: ROM:00051B9E   o  ; was: sub_52028
                tst.w   (word_FF80C2).w
                bne.s   loc_5203C
                move.w  #$1E,4(a5)
                clr.b   (byte_FF80EC).w
                bra.w   Boss_ZLeo_AttackPattern1_WaitLoop
; ---------------------------------------------------------------------------
loc_5203C:                                              ; CODE XREF: Boss_ZLeoDefeatCheck+4   j
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; End of function Boss_ZLeoDefeatCheck
; Attack pattern 2 handler
Boss_ZLeoAttackPattern2:                                ; CODE XREF: Boss_ZLeoMain+24   j  ; was: sub_52046
                move.w  #6,4(a5)
                move.b  #$40,(byte_FFF705).w            ; '@'
                move.w  #8,(word_FF808C).w
                move.b  #2,(byte_FF80EC).w
                bset    #0,(byte_FFA272).w
                clr.b   $21(a5)
                move.w  #$34,(word_FFA02A).w            ; '4'
                bset    #2,(word_FFDB22).w
                move.l  #$FFFF0000,(dword_FFDB3C).w
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$C0,$11C(a5)
                bsr.w   Boss_ZLeoAnimationUpdate1
                move.b  #1,(byte_FF830E).w
; Z-Leo boss transition state
Boss_ZLeoAttack_State10:                                ; DATA XREF: ROM:00051B88   o  ; was: loc_52096
                subq.w  #1,$11C(a5)
                bmi.s   loc_520C0
                move.w  #4,(word_FFA010).w
                move.w  #1,(word_FFA014).w
                jsr     (Gfx_UpdatePaletteFade).l
                bsr.w   Boss_ZLeoAnimationUpdate2
                bsr.w   Boss_ZLeoAnimationUpdate3
                lea     word_52C68(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_520C0:                                              ; CODE XREF: Boss_ZLeoAttackPattern2+54   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
; Z-Leo boss special move
Boss_ZLeoAttack_State12:                                ; DATA XREF: ROM:00051B8A   o  ; was: loc_520C8
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_520DE
                addq.w  #1,$11C(a5)
                cmpi.w  #8,$11C(a5)
                beq.s   loc_520F0
loc_520DE:                                              ; CODE XREF: Boss_ZLeoAttackPattern2+8A   j
                bsr.w   Boss_ZLeoFadeoutPalette
                bsr.w   Boss_ZLeoAnimationUpdate2
                lea     word_52C68(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_520F0:                                              ; CODE XREF: Boss_ZLeoAttackPattern2+96   j
                addq.w  #2,4(a5)
                clr.w   $11C(a5)
                movea.w #(byte_FFDB80-M68K_RAM),a0
                move.w  #$354,(a0)
                clr.w   4(a0)
                move.w  #$120,$10(a0)
                move.w  #$F0,$14(a0)
                movea.l #$FFFF2080,a0
                move.w  #$6000,d0
                moveq   #3,d7
                jsr     (Gfx_AdjustTileIndices).l
                lea     word_52154(pc),a0
                nop
                jsr     (Gfx_LoadCompressedTiles).l
                move.b  #$14,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackPattern2
; Z-Leo defeat sequence - increments timer to $11, triggers sprite clearing and palette fade to white ($EEE)
Boss_ZLeoDefeatedFadeout:                               ; DATA XREF: ROM:00051B8C   o  ; was: sub_52138
                move.w  (word_FFA000).w,d0
                andi.w  #3,d0
                bne.s   loc_5214E
                addq.w  #1,$11C(a5)
                cmpi.w  #$11,$11C(a5)
                beq.s   loc_5215E
loc_5214E:                                              ; CODE XREF: Boss_ZLeoDefeatedFadeout+8   j
                bsr.w   Boss_ZLeoFadeoutPalette
                rts
; ---------------------------------------------------------------------------
word_52154:     dc.w    $4618, $2000, $300, $405, $607
                                        ; DATA XREF: Boss_ZLeoAttackPattern2+DC   o
; ---------------------------------------------------------------------------
loc_5215E:                                              ; CODE XREF: Boss_ZLeoDefeatedFadeout+14   j
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$120,$48(a5)
                move.w  #$3F8,d0
                moveq   #0,d1
                jsr     (Object_ClearAllExceptTypes).l
                movea.w #(word_FFE380-M68K_RAM),a0
                move.w  #$EEE,d0
                moveq   #$3F,d7                         ; '?'
loc_52182:                                              ; CODE XREF: Boss_ZLeoDefeatedFadeout+50   j
                move.w  d0,-$80(a0)
                move.w  d0,(a0)+
                dbf     d7,loc_52182
; End of function Boss_ZLeoDefeatedFadeout
; Delay state after Z-Leo defeat - waits for timer, then initializes battle UI and weapon display
Boss_ZLeoDefeatedDelay:                                 ; DATA XREF: ROM:00051B8E   o  ; was: sub_5218C
                subq.w  #1,$48(a5)
                bmi.s   loc_52194
                rts
; ---------------------------------------------------------------------------
loc_52194:                                              ; CODE XREF: Boss_ZLeoDefeatedDelay+4   j
                addq.w  #2,4(a5)
                move.w  #$8002,(word_FF80F2).w
                clr.w   (word_FF80F0).w
                move.w  #$E000,(word_FF80F4).w
                move.b  #$80,(byte_FFF705).w
                move.w  #2,(word_FFA29C).w
                move.w  #4,(word_FF8230).w
                jmp     UI_StoreWeaponToBuffer
; End of function Boss_ZLeoDefeatedDelay
; Empty Z-Leo boss state handler
Boss_ZLeoEmptyState:                                    ; DATA XREF: ROM:00051B90   o  ; was: nullsub_121
                rts
; End of function Boss_ZLeoEmptyState
; Attack pattern 1 handler
Boss_ZLeoAttackPattern1:                                ; CODE XREF: Boss_ZLeoAttackState1+5E   j  ; was: sub_521C2
                                        ; Boss_ZLeoRisingAttack+C6   j
                move.w  #$1E,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $47C(a5)
; Main attack pattern state with timer and laser spawning
Boss_ZLeo_AttackPattern1_WaitLoop:                      ; CODE XREF: Boss_ZLeoDefeatCheck+10   j  ; was: loc_521D6
                                        ; DATA XREF: ROM:00051BA0   o
                subq.w  #1,$11C(a5)
                bpl.s   loc_52200
                cmpi.w  #$4200,(word_FF8200).w
                bpl.s   loc_521F8
                moveq   #3,d1
                cmpi.w  #$2500,(word_FF8200).w
                bpl.s   loc_521F0
                moveq   #1,d1
loc_521F0:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+2A   j
                move.w  (dword_FFFF08).w,d0
                and.w   d1,d0
                beq.s   loc_521FC
loc_521F8:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+20   j
                bra.w   loc_5220A
; ---------------------------------------------------------------------------
loc_521FC:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+34   j
                bra.w   Boss_ZLeoAttackInit
; ---------------------------------------------------------------------------
loc_52200:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+18   j
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5220A:                                              ; CODE XREF: Boss_ZLeoAttackPattern1:loc_521F8   j
                move.w  #$38,4(a5)                      ; '8'
                bsr.w   Boss_ZLeoAnimationUpdate1
                move.w  #$80,$11C(a5)
                bsr.w   Boss_ZLeoSpawnLaser
                move.w  #4,$B28(a5)
                move.w  #4,$C48(a5)
; Z-Leo boss advanced attack
Boss_ZLeoAttack_State36:                                ; DATA XREF: ROM:00051BBA   o  ; was: loc_5222A
                cmpi.w  #$60,$11C(a5)                   ; '`'
                bne.s   loc_52236
                bsr.w   Boss_ZLeoLoadDefeatTiles
loc_52236:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+6E   j
                subq.w  #1,$11C(a5)
                bpl.s   loc_52252
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.w  d0,$47E(a5)
                move.l  off_5225C(pc,d0.w),$3BC(a5)
                bra.w   loc_5226C
; ---------------------------------------------------------------------------
loc_52252:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+78   j
                lea     word_52CB0(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
off_5225C:      dc.l    word_52CCC                      ; DATA XREF: Boss_ZLeoAttackPattern1+86   r
                dc.l    word_52CE0
                dc.l    word_52CF4
                dc.l    word_52D08
; ---------------------------------------------------------------------------
loc_5226C:                                              ; CODE XREF: Boss_ZLeoAttackPattern1+8C   j
                move.w  #$20,4(a5)                      ; ' '
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                move.b  #$D1,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackPattern1
; Attack state 1 handler
Boss_ZLeoAttackState1:                                  ; DATA XREF: ROM:00051BA2   o  ; was: sub_5228A
                bclr    #0,$23E(a5)
                bne.s   loc_5229A
                movea.l $3BC(a5),a1
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5229A:                                              ; CODE XREF: Boss_ZLeoAttackState1+6   j
                addq.w  #2,4(a5)
; Z-Leo boss mid phase
Boss_ZLeoAttack_State28:                                ; DATA XREF: ROM:00051BA4   o  ; was: loc_5229E
                tst.w   $58(a5)
                bmi.s   loc_522B0
                bsr.w   Boss_ZLeoSpawnOrb
                movea.l $3BC(a5),a1
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_522B0:                                              ; CODE XREF: Boss_ZLeoAttackState1+18   j
                addq.w  #2,4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$10,$11C(a5)
; Z-Leo boss rapid attack
Boss_ZLeoAttack_State30:                                ; DATA XREF: ROM:00051BA6   o  ; was: loc_522C4
                subq.w  #1,$11C(a5)
                bne.s   loc_522DC
                cmpi.w  #8,$47E(a5)
                bne.s   loc_522DC
                move.b  #$3A,d0                         ; ':'
                jsr     (Sound_PlaySFX).l
loc_522DC:                                              ; CODE XREF: Boss_ZLeoAttackState1+3E   j
                                        ; Boss_ZLeoAttackState1+46   j
                tst.w   $58(a5)
                bpl.s   loc_522EC
                move.w  #$40,$11C(a5)                   ; '@'
                bra.w   Boss_ZLeoAttackPattern1
; ---------------------------------------------------------------------------
loc_522EC:                                              ; CODE XREF: Boss_ZLeoAttackState1+56   j
                lea     word_52CC2(pc),a1
                nop
                bra.w   loc_52624
; End of function Boss_ZLeoAttackState1
; Initializes Z-Leo attack state - sets state $26, clears animation, enables screen effects and attack flags
Boss_ZLeoAttackInit:                                    ; CODE XREF: Boss_ZLeoAttackPattern1:loc_521FC   j  ; was: sub_522F6
                move.w  #$26,4(a5)                      ; '&'
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                clr.b   $23E(a5)
                bset    #1,(byte_FF80EC).w
                clr.b   $21(a5)
                bset    #0,(byte_FFA272).w
; Z-Leo boss ultimate move
Boss_ZLeoAttack_State32:                                ; DATA XREF: ROM:00051BA8   o  ; was: loc_5231A
                bclr    #0,$23E(a5)
                bne.s   loc_5232C
                lea     word_52D1C(pc),a1
                nop
                bra.w   loc_52624
; ---------------------------------------------------------------------------
loc_5232C:                                              ; CODE XREF: Boss_ZLeoAttackInit+2A   j
                addq.w  #2,4(a5)
                bset    #2,(byte_FF8245).w
                bset    #2,(word_FFDB22).w
                move.l  #$FFF00000,(dword_FFDB3C).w
                move.b  #$4F,d0                         ; 'O'
                jsr     (Sound_PlaySFX).l
                bsr.w   Boss_ZLeoAnimationUpdate1
                move.w  #$E000,$59E(a5)
                move.w  #$FFF8,$59C(a5)
                move.b  #$13,d0
                jsr     (Sound_PlaySFX).l
; End of function Boss_ZLeoAttackInit
; Z-Leo main attack sequence - handles laser spawning, vertical movement phases, screen scrolling, and palette cycling
Boss_ZLeoAttackSequence:                                ; DATA XREF: ROM:00051BAA   o  ; was: sub_52368
                tst.w   $58(a5)
                bmi.s   loc_52396
                cmpi.w  #$40,(dword_FFDB34).w           ; '@'
                bpl.s   loc_5238C
                move.w  #$34,(word_FFA02A).w            ; '4'
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                clr.l   (dword_FFDB3C).w
loc_5238C:                                              ; CODE XREF: Boss_ZLeoAttackSequence+C   j
                lea     word_52D1C(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_52396:                                              ; CODE XREF: Boss_ZLeoAttackSequence+4   j
                addq.w  #2,4(a5)
                move.w  #3,$11C(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
; Z-Leo boss final phase entry
Boss_ZLeoAttack_State38:                                ; DATA XREF: ROM:00051BAC   o  ; was: loc_523AA
                bclr    #0,$23E(a5)
                beq.s   loc_523D2
                movea.w #(byte_FFD100-M68K_RAM),a4
                btst    #0,$11D(a5)
                bne.s   loc_523C2
                movea.w #(byte_FFD220-M68K_RAM),a4
loc_523C2:                                              ; CODE XREF: Boss_ZLeoAttackSequence+54   j
                move.w  #9,$48(a4)
                bsr.w   Projectile_ZLeoSpawnLasers
                subq.w  #1,$11C(a5)
                bmi.s   loc_523EC
loc_523D2:                                              ; CODE XREF: Boss_ZLeoAttackSequence+48   j
                tst.w   $58(a5)
                bpl.s   loc_523E2
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_523E2:                                              ; CODE XREF: Boss_ZLeoAttackSequence+6E   j
                lea     word_52D44(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_523EC:                                              ; CODE XREF: Boss_ZLeoAttackSequence+68   j
                addq.w  #2,4(a5)
                move.b  #1,$47C(a5)
                clr.l   $41C(a5)
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 1
Boss_ZLeoAttack_State40:                                ; DATA XREF: ROM:00051BAE   o  ; was: loc_52400
                subq.w  #1,$11C(a5)
                bmi.s   loc_52446
                addi.l  #$4000,$41C(a5)
                cmpi.l  #$78000,$41C(a5)
                bmi.s   loc_52420
                move.l  #$78000,$41C(a5)
loc_52420:                                              ; CODE XREF: Boss_ZLeoAttackSequence+AE   j
                move.l  $41C(a5),d0
                asl.l   #2,d0
                add.l   d0,$35C(a5)
                cmpi.w  #$180,$35C(a5)
                bmi.s   loc_52438
                move.w  #$180,$35C(a5)
loc_52438:                                              ; CODE XREF: Boss_ZLeoAttackSequence+C8   j
                bsr.w   Boss_ZLeoScrollUpdate
                lea     word_52D44(pc),a1
                nop
                bra.w   loc_5262E
; ---------------------------------------------------------------------------
loc_52446:                                              ; CODE XREF: Boss_ZLeoAttackSequence+9C   j
                addq.w  #2,4(a5)
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 2
Boss_ZLeoAttack_State42:                                ; DATA XREF: ROM:00051BB0   o  ; was: loc_52450
                subq.w  #1,$11C(a5)
                bmi.s   loc_52462
loc_52456:                                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_5250E   j
                bsr.w   Boss_ZLeoScrollUpdate
                bsr.w   Boss_ZLeoTileUpdate
                bra.w   Boss_ZLeoGraphicsInit2
; ---------------------------------------------------------------------------
loc_52462:                                              ; CODE XREF: Boss_ZLeoAttackSequence+EC   j
                addq.w  #2,4(a5)
                move.l  #$FFC00000,(dword_FFDB34).w
                move.l  #$50000,(dword_FFDB3C).w
                move.w  #$120,(dword_FFA410).w
                move.w  (dword_FFDB34).w,d0
                subi.w  #$20,d0                         ; ' '
                move.w  d0,(dword_FFA414).w
                move.w  #$80,$11C(a5)
; Z-Leo boss final attack 3
Boss_ZLeoAttack_State44:                                ; DATA XREF: ROM:00051BB2   o  ; was: loc_5248E
                tst.w   (word_FFA02A).w
                beq.s   loc_524AC
                cmpi.w  #$C0,(dword_FFDB34).w
                bmi.s   loc_524AC
                clr.w   (word_FFA02A).w
                bclr    #2,(byte_FF8245).w
                bclr    #0,(byte_FFA272).w
loc_524AC:                                              ; CODE XREF: Boss_ZLeoAttackSequence+12A   j
                                        ; Boss_ZLeoAttackSequence+132   j
                btst    #2,(word_FFDB22).w
                beq.s   loc_524C8
                subi.l  #$880,(dword_FFDB3C).w
                bpl.s   loc_524CE
                bclr    #2,(word_FFDB22).w
                clr.l   (dword_FFDB3C).w
loc_524C8:                                              ; CODE XREF: Boss_ZLeoAttackSequence+14A   j
                subq.w  #1,$11C(a5)
                bmi.s   loc_524EA
loc_524CE:                                              ; CODE XREF: Boss_ZLeoAttackSequence+154   j
                subi.l  #$2000,$41C(a5)
                cmpi.l  #$FFF88000,$41C(a5)
                bpl.s   loc_524E8
                move.l  #$FFF88000,$41C(a5)
loc_524E8:                                              ; CODE XREF: Boss_ZLeoAttackSequence+176   j
                bra.s   loc_524F6
; ---------------------------------------------------------------------------
loc_524EA:                                              ; CODE XREF: Boss_ZLeoAttackSequence+164   j
                addq.w  #2,4(a5)
; Z-Leo boss final attack 4
Boss_ZLeoAttack_State46:                                ; DATA XREF: ROM:00051BB4   o  ; was: loc_524EE
                cmpi.w  #$240,(dword_FFA90C).w
                bmi.s   Boss_ZLeoRisingAttack
loc_524F6:                                              ; CODE XREF: Boss_ZLeoAttackSequence:loc_524E8   j
                bsr.w   Boss_ZLeoPaletteRotate
                tst.w   (word_FFA02A).w
                bne.s   loc_5250E
                move.w  (word_FFA000).w,d0
                andi.w  #$F,d0
                bne.s   loc_5250E
                bsr.w   Projectile_ZLeoSpawnDropProjectile
loc_5250E:                                              ; CODE XREF: Boss_ZLeoAttackSequence+196   j
                                        ; Boss_ZLeoAttackSequence+1A0   j
                bra.w   loc_52456
; End of function Boss_ZLeoAttackSequence
; Cycles Z-Leo palette colors based on frame counter - rotates 3 palette entries in 4 different patterns
