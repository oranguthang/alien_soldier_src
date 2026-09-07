UI_UpdateWeaponDisplay:                              ; CODE XREF: Sys_GameplayMainLoop+B8   p  ; was: sub_178FE
                                        ; Sys_UpdateGameplayLoop+2A   p
                tst.b   (byte_FF813E).w
                bmi.w UI_UpdateWeaponDisplay_Return
                bsr.w UI_ProcessWeaponState
                move.w  (word_FFA24E).w,d0
                cmpi.w  #$12,(word_FFA21C).w
                bmi.s   loc_17918
                moveq   #8,d0
loc_17918:                              ; CODE XREF: UI_UpdateWeaponDisplay+16   j
                movea.w #(word_FFA250-M68K_RAM),a0
                lea     word_178DA(pc),a1
                moveq   #0,d1
                moveq   #3,d7
loc_17924:                              ; CODE XREF: UI_UpdateWeaponDisplay+4E   j
                cmp.w   d0,d1
                beq.s UI_UpdateWeaponIconLoop
                move.w  (a0),d2
                subq.w  #1,8(a0)
                bpl.s UI_UpdateWeaponIconLoop
                move.w  (a1,d2.w),8(a0)
                addq.w  #2,$10(a0)
                move.w  $18(a0),d2
                cmp.w   $10(a0),d2
                bpl.s UI_UpdateWeaponIconLoop
                move.w  d2,$10(a0)
; Updates weapon icon display positions with interpolation loop
UI_UpdateWeaponIconLoop:                              ; CODE XREF: UI_UpdateWeaponDisplay+28   j  ; was: loc_17948
                                        ; UI_UpdateWeaponDisplay+30   j ...
                addq.w  #2,a0
                addq.w  #2,d1
                dbf     d7,loc_17924
; Return after updating weapon display loop
UI_UpdateWeaponDisplay_Return:                           ; CODE XREF: UI_UpdateWeaponDisplay+4   j  ; was: locret_17950
                                        ; DATA XREF: ROM:off_17984   o ...
                rts
; End of function UI_UpdateWeaponDisplay
; Processes weapon display state dispatcher
UI_ProcessWeaponState:                              ; CODE XREF: UI_UpdateWeaponDisplay+8   p  ; was: sub_17952
                movea.w (word_FFA24E).w,a1
                adda.w  #$A250,a1
                lea     off_1938E(pc),a2
                nop
                tst.w   (word_FF8238).w
                bmi.s   loc_1796A
                subq.w  #1,(word_FF8238).w
loc_1796A:                              ; CODE XREF: UI_ProcessWeaponState+12   j
                tst.w   (word_FF8038).w
                bmi.s UI_DispatchWeaponHandler
                subq.w  #1,(word_FF8038).w
; Dispatches to weapon handler routine using jump table with UI_GetWeaponIconData as base
UI_DispatchWeaponHandler:                              ; CODE XREF: UI_ProcessWeaponState+1C   j  ; was: loc_17974
                move.w  (word_FFA21C).w,d0
                movea.w off_17984(pc,d0.w),a0
                adda.l  #UI_GetWeaponIconData,a0
                jmp     (a0)
; End of function UI_ProcessWeaponState
; ---------------------------------------------------------------------------
off_17984:      dc.w UI_UpdateWeaponDisplay_Return-UI_GetWeaponIconData
                                        ; DATA XREF: UI_ProcessWeaponState+26   r
                dc.w UI_CalculateHealthBarSegments-UI_GetWeaponIconData
                dc.w UI_InitHealthBarSprites-UI_GetWeaponIconData
                dc.w Enemy_CalculateVelocityFromPlayer-UI_GetWeaponIconData
                dc.w UI_ProcessTargetingSystem-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponGaugeSprite-UI_GetWeaponIconData
                dc.w Gfx_LoadWeaponIcon-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponDisplay_Return-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponDisplay_Return-UI_GetWeaponIconData
                dc.w UI_InitWeaponSelectScreen-UI_GetWeaponIconData
                dc.w UI_UpdateWeaponSelect-UI_GetWeaponIconData


; Gets weapon icon data from table
UI_GetWeaponIconData:                              ; CODE XREF: Enemy_UpdateBossAI+76   p  ; was: sub_1799A
                                        ; Enemy_UpdateBossAI+B2   p
                                        ; DATA XREF: ...
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (word_FFA21C).w,d0
                move.w  word_179AC(pc,d0.w),d0
                rts
; End of function UI_GetWeaponIconData
; ---------------------------------------------------------------------------
word_179AC:     dc.w 0, 2, 4, 6, 8, $A, $C, $E, $10, 0, 0
                                        ; DATA XREF: UI_GetWeaponIconData+C   r


; Initializes weapon select UI with sprites and animation tables
UI_InitWeaponSelectScreen:                              ; DATA XREF: ROM:00017996   o  ; was: sub_179C2
                movea.w #(byte_FFA258-M68K_RAM),a0
                move.w  (word_FFA24E).w,d0
                move.w  #$258,(a0,d0.w)
                move.w  (word_FFA24E).w,d0
                move.w  d0,(word_FF803C).w
                addq.w  #2,(word_FFA21C).w
                bsr.w UI_ClearWeaponCounters
                move.w  #$14,(word_FFA21E).w
                lea     word_17AA4(pc),a0
                nop
                move.w  (word_FF803C).w,d1
                move.w  (a0,d1.w),d1
                addi.w  #$100,d1
                andi.w  #$1FF,d1
                move.w  d1,(word_FF8036).w
                move.w  #$A0,(word_FF8030).w
                move.w  d0,(word_FF8238).w
                bsr.w Memory_ClearBlock
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                move.w  #$10,(a0)
                move.l  #off_E968C,8(a0)
                move.w  #$E080,2(a0)
                move.w  #$80,$10(a0)
                move.w  #$80,$14(a0)
                move.w  #$C80,$E(a0)
                move.w  (word_FF808A).w,d6
                or.w    d6,$E(a0)
                movea.w #(byte_FFC320-M68K_RAM),a0
                movea.w #(word_FFA250-M68K_RAM),a1
                lea     word_17A9C(pc),a3
                nop
                lea     off_178E6(pc),a4
                movea.w #(word_FFA400-M68K_RAM),a5
                move.w  (word_FF808A).w,d3
                moveq   #0,d4
                moveq   #3,d7
; Initializes weapon selection screen slot data in loop
UI_InitWeaponSlotLoop:                              ; CODE XREF: UI_InitWeaponSelectScreen+CC   j  ; was: loc_17A5C
                move.w  #$3C,(a0) ; '<'
                move.w  #$C080,2(a0)
                move.w  $10(a2),$10(a0)
                move.w  $14(a2),$14(a0)
                move.w  d3,$E(a0)
                move.w  (a1)+,d0
                asl.w   #1,d0
                move.l  (a4,d0.w),8(a0)
                move.w  d4,$48(a0)
                move.w  (a3)+,$50(a0)
                addq.w  #2,d4
                lea     $60(a0),a0
                dbf d7,UI_InitWeaponSlotLoop
                move.b  #$C0,d0
                jmp (Sound_PlaySFX).l
; End of function UI_InitWeaponSelectScreen
; ---------------------------------------------------------------------------
word_17A9C:     dc.w $180, 0, $80, $100 ; DATA XREF: UI_InitWeaponSelectScreen+84   o
word_17AA4:     dc.w 0, $180, $100, $80 ; DATA XREF: UI_InitWeaponSelectScreen+24   o
                                        ; UI_HandleWeaponSelectInput+8   r


; Handles rotation input on weapon select screen with sound
UI_HandleWeaponSelectInput:                              ; CODE XREF: UI_UpdateWeaponSelect:loc_17BD6   p  ; was: sub_17AAC
                move.w  (word_FF8036).w,d0
                move.w  (word_FF803C).w,d1
                cmp.w   word_17AA4(pc,d1.w),d0
                beq.s   loc_17AC8
                add.w   (word_FF803A).w,d0
                andi.w  #$1F0,d0
                move.w  d0,(word_FF8036).w
                rts
; ---------------------------------------------------------------------------
loc_17AC8:                              ; CODE XREF: UI_HandleWeaponSelectInput+C   j
                btst    #3,(byte_FFA46A).w
                beq.s   loc_17AEA
                move.w  #$FFF0,(word_FF803A).w
                addq.w  #2,(word_FF803C).w
                andi.w  #6,(word_FF803C).w
                move.b  #$A8,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
loc_17AEA:                              ; CODE XREF: UI_HandleWeaponSelectInput+22   j
                btst    #2,(byte_FFA46A).w
                beq.s   locret_17B0C
                move.w  #$10,(word_FF803A).w
                subq.w  #2,(word_FF803C).w
                andi.w  #6,(word_FF803C).w
                move.b  #$A8,d0
                jmp (Sound_PlaySFX).l
; ---------------------------------------------------------------------------
locret_17B0C:                           ; CODE XREF: UI_HandleWeaponSelectInput+44   j
                rts
; End of function UI_HandleWeaponSelectInput
; Handles D-pad weapon selection
UI_HandleDPadWeaponSelect:
                move.b  (byte_FFA46A).w,d0  ; was: sub_17B0E
                andi.b  #$F,d0
                beq.s   locret_17B32
                move.b  #$A8,d0
                jsr (Sound_PlaySFX).l
                move.b  (byte_FFA46A).w,d0
                btst    #0,d0
                beq.s   loc_17B34
                move.w  #0,(word_FF803C).w
locret_17B32:                           ; CODE XREF: UI_HandleDPadWeaponSelect+8   j
                                        ; UI_HandleDPadWeaponSelect+46   j
                rts
; ---------------------------------------------------------------------------
loc_17B34:                              ; CODE XREF: UI_HandleDPadWeaponSelect+1C   j
                btst    #1,d0
                beq.s   loc_17B42
                move.w  #4,(word_FF803C).w
                rts
; ---------------------------------------------------------------------------
loc_17B42:                              ; CODE XREF: UI_HandleDPadWeaponSelect+2A   j
                btst    #3,d0
                beq.s   loc_17B50
                move.w  #2,(word_FF803C).w
                rts
; ---------------------------------------------------------------------------
loc_17B50:                              ; CODE XREF: UI_HandleDPadWeaponSelect+38   j
                btst    #2,d0
                beq.s   locret_17B32
                move.w  #6,(word_FF803C).w
                rts
; End of function UI_HandleDPadWeaponSelect
; Clears weapon use counters
UI_ClearWeaponCounters:                              ; CODE XREF: UI_InitWeaponSelectScreen+1A   p  ; was: sub_17B5E
                                        ; UI_IncrementWeaponSelection+16   p ...
                moveq   #0,d0
                move.w  d0,(word_FF801C).w
                move.w  d0,(word_FF801E).w
                move.w  d0,(dword_FF8020).w
                move.w  d0,(dword_FF8020+2).w
                move.w  d0,(dword_FF8024).w
                move.w  d0,(dword_FF8024+2).w
                move.w  d0,(dword_FF8028).w
                move.w  d0,(dword_FF8028+2).w
                move.w  d0,(dword_FF802C).w
                move.w  d0,(dword_FF802C+2).w
                rts
; End of function UI_ClearWeaponCounters
; Main update loop for weapon select screen with collision check
UI_UpdateWeaponSelect:                              ; DATA XREF: ROM:00017998   o  ; was: sub_17B8A
                bsr.w UI_SaveWeaponIndex
                tst.w   (word_FF80E6).w
                bne.w   loc_17BEC
                btst    #6,(byte_FF8244).w
                bne.s   loc_17BA8
                btst    #0,(byte_FF8244).w
                bne.w UI_UpdateWeaponSelection
loc_17BA8:                              ; CODE XREF: UI_UpdateWeaponSelect+12   j
                tst.w   (word_FFA02A).w
                bne.w UI_UpdateWeaponSelection
                subi.w  #8,(word_FF8030).w
                cmpi.w  #$20,(word_FF8030).w ; ' '
                bmi.s   loc_17BD6
                moveq   #$10,d0
                btst    #3,(word_FFA40E).w
                bne.s   loc_17BCA
                moveq   #$FFFFFFF0,d0
loc_17BCA:                              ; CODE XREF: UI_UpdateWeaponSelect+3C   j
                add.w   d0,(word_FF8036).w
                andi.w  #$1F8,(word_FF8036).w
                rts
; ---------------------------------------------------------------------------
loc_17BD6:                              ; CODE XREF: UI_UpdateWeaponSelect+32   j
                bsr.w UI_HandleWeaponSelectInput
                move.w  #$20,(word_FF8030).w ; ' '
                move.b  (byte_FFA46A).w,d0
                andi.b  #$70,d0 ; 'p'
                bne.s   loc_17BEC
                rts
; ---------------------------------------------------------------------------
loc_17BEC:                              ; CODE XREF: UI_UpdateWeaponSelect+8   j
                                        ; UI_UpdateWeaponSelect+5E   j
                move.b  #$A7,d0
                jsr (Sound_PlaySFX).l
                move.w  #8,(word_FF8038).w
; End of function UI_UpdateWeaponSelect
; Increments weapon selection index
UI_IncrementWeaponSelection:                              ; CODE XREF: Player_InitializeStats+76   j  ; was: sub_17BFC
                                        ; UI_HandleOptionSelection+7A   p ...
                movea.w (word_FFA24E).w,a0
                adda.w  #$A250,a0
                move.w  (a0),d0
                addq.w  #2,d0
                move.w  d0,(word_FFA21C).w
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                bsr.w UI_ClearWeaponCounters
                bra.w Sys_ClearObjectBufferSmall
; End of function UI_IncrementWeaponSelection
; Updates weapon selection index and clears object buffer
UI_UpdateWeaponSelection:                              ; CODE XREF: UI_UpdateWeaponSelect+1A   j  ; was: sub_17C1A
                                        ; UI_UpdateWeaponSelect+22   j ...
                move.w  (word_FFA21C).w,d0
                bne.s   loc_17C26
                clr.w   (word_FFA220).w
                bra.s   loc_17C2C
; ---------------------------------------------------------------------------
loc_17C26:                              ; CODE XREF: UI_UpdateWeaponSelection+4   j
                cmpi.w  #$12,d0
                bmi.s   loc_17C40
loc_17C2C:                              ; CODE XREF: UI_UpdateWeaponSelection+A   j
                movea.w (word_FFA220).w,a0
                move.w  a0,(word_FFA24E).w
                adda.w  #$A250,a0
                move.w  (a0),d0
                addq.w  #2,d0
                move.w  d0,(word_FFA21C).w
loc_17C40:                              ; CODE XREF: UI_UpdateWeaponSelection+10   j
                asl.w   #1,d0
                move.w  d0,(word_FFA21E).w
                clr.w   (word_FF8038).w
                bra.w Sys_ClearObjectBufferSmall
; End of function UI_UpdateWeaponSelection
; Saves current weapon selection index to RAM
UI_SaveWeaponIndex:                              ; CODE XREF: UI_UpdateWeaponSelect   p  ; was: sub_17C4E
                move.w  (word_FF803C).w,(word_FFA24E).w
                rts
; End of function UI_SaveWeaponIndex
; Calculates number of health bar segments to display based on player health value
UI_CalculateHealthBarSegments:                              ; DATA XREF: ROM:00017986   o  ; was: sub_17C56
                moveq   #$E,d0
                move.w  $10(a1),d1
                cmpi.w  #$708,d1
                bpl.s   loc_17C74
                subq.w  #2,d0
                cmpi.w  #$3E8,d1
                bpl.s   loc_17C74
                subq.w  #2,d0
                cmpi.w  #$320,d1
                bpl.s   loc_17C74
                subq.w  #2,d0
loc_17C74:                              ; CODE XREF: UI_CalculateHealthBarSegments+A   j
                                        ; UI_CalculateHealthBarSegments+12   j ...
                move.w  d0,(dword_FF802C).w
                bra.w UI_RenderTargetingReticle
; End of function UI_CalculateHealthBarSegments
; Initializes health bar sprite objects with properties and positions
UI_InitHealthBarSprites:                              ; DATA XREF: ROM:00017988   o  ; was: sub_17C7C
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #3,d7
loc_17C82:                              ; CODE XREF: UI_InitHealthBarSprites+1E   j
                tst.w   (a0)
                bne.s   loc_17C96
                move.w  #$A0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$22C,$48(a0)
loc_17C96:                              ; CODE XREF: UI_InitHealthBarSprites+8   j
                lea     $C0(a0),a0
                dbf     d7,loc_17C82
                clr.w   (dword_FF802C).w
                move.w  $10(a1),d0
                cmpi.w  #$320,d0
                bmi.s UI_SetHealthBarFlag
                addq.w  #1,(dword_FF802C).w
; Sets health bar display flag based on player health threshold
UI_SetHealthBarFlag:                              ; CODE XREF: UI_InitHealthBarSprites+2E   j  ; was: loc_17CB0
                bra.w UI_RenderTargetingReticle
; End of function UI_InitHealthBarSprites
; Calculates projectile velocity based on player X position
Enemy_CalculateVelocityFromPlayer:                              ; DATA XREF: ROM:0001798A   o  ; was: sub_17CB4
                move.w  (word_FFA000).w,d0
                btst    #7,d0
                bne.s   loc_17CD4
                andi.w  #$7F,d0
                cmpi.w  #$40,d0 ; '@'
                bmi.s   loc_17CD4
                move.w  (dword_FFFF08).w,d3
                andi.w  #1,d3
                addq.w  #3,d3
                bra.s   loc_17CEA
; ---------------------------------------------------------------------------
loc_17CD4:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+8   j
                                        ; Enemy_CalculateVelocityFromPlayer+12   j
                move.w  $10(a1),d0
                moveq   #2,d3
                cmpi.w  #$3E8,d0
                bmi.s   loc_17CEA
                moveq   #3,d3
                cmpi.w  #$708,d0
                bmi.s   loc_17CEA
                moveq   #4,d3
loc_17CEA:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+1E   j
                                        ; Enemy_CalculateVelocityFromPlayer+2A   j ...
                movea.l #word_1B514,a0
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1FE,d0
                move.w  -$80(a0,d0.w),d1
                move.w  (a0,d0.w),d2
                ext.l   d1
                ext.l   d2
                asl.l   d3,d1
                asl.l   d3,d2
                move.l  d1,(dword_FF8024).w
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                add.l   d0,d2
                move.l  d2,(dword_FF8028).w
                moveq   #0,d0
                move.w  $10(a1),d0
                cmpi.w  #$7D0,d0
                bmi.s   loc_17D2E
                move.l  #dword_19812,(dword_FF802C).w
                rts
; ---------------------------------------------------------------------------
loc_17D2E:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+6E   j
                subq.w  #8,d0
                bpl.s   loc_17D34
                moveq   #0,d0
loc_17D34:                              ; CODE XREF: Enemy_CalculateVelocityFromPlayer+7C   j
                divs.w  #$FA,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  (a2,d0.w),(dword_FF802C).w
                rts
; End of function Enemy_CalculateVelocityFromPlayer
; Processes targeting reticle system with enemy detection and sprite management
UI_ProcessTargetingSystem:                              ; DATA XREF: ROM:0001798C   o  ; was: sub_17D46
                move.w  #0,(dword_FF8028+2).w
                moveq   #0,d0
                move.w  $10(a1),d0
                bne.s   loc_17D5A
                move.w  #1,(dword_FF8028+2).w
loc_17D5A:                              ; CODE XREF: UI_ProcessTargetingSystem+C   j
                cmpi.w  #$3E8,d0
                bmi.s   loc_17D64
                moveq   #$1C,d0
                bra.s   loc_17D74
; ---------------------------------------------------------------------------
loc_17D64:                              ; CODE XREF: UI_ProcessTargetingSystem+18   j
                subq.w  #8,d0
                bpl.s   loc_17D6A
                moveq   #0,d0
loc_17D6A:                              ; CODE XREF: UI_ProcessTargetingSystem+20   j
                divs.w  #$7D,d0 ; '}'
                asl.w   #2,d0
                andi.w  #$1C,d0
loc_17D74:                              ; CODE XREF: UI_ProcessTargetingSystem+1C   j
                move.l  -$C(a2,d0.w),(dword_FF802C).w
                movea.w #(byte_FFC2C0-M68K_RAM),a0
                moveq   #3,d7
loc_17D80:                              ; CODE XREF: UI_ProcessTargetingSystem+52   j
                tst.w   (a0)
                bne.s   loc_17D94
                move.w  #$A0,(a0)
                move.w  #$8080,2(a0)
                move.w  #$6C,$48(a0) ; 'l'
loc_17D94:                              ; CODE XREF: UI_ProcessTargetingSystem+3C   j
                lea     $C0(a0),a0
                dbf     d7,loc_17D80
                clr.w   (word_FF801C).w
                move.w  (word_FF8D7A).w,d7
                bmi.s   loc_17DCE
                movea.w #(byte_FF8E80-M68K_RAM),a1
loc_17DAA:                              ; CODE XREF: UI_ProcessTargetingSystem+6E   j
                movea.w (a1)+,a0
                btst    #7,$23(a0)
                bne.s   loc_17DBA
                dbf     d7,loc_17DAA
                rts
; ---------------------------------------------------------------------------
loc_17DBA:                              ; CODE XREF: UI_ProcessTargetingSystem+6C   j
                move.w  a0,(word_FF801C).w
                btst    #4,(word_FFF706).w
                beq.w   loc_19298
                moveq   #1,d6
                bra.w UI_CalculateReticlePosition
; ---------------------------------------------------------------------------
loc_17DCE:                              ; CODE XREF: UI_ProcessTargetingSystem+5E   j
                move.w  (word_FF8D78).w,d7
                bmi.s   locret_17DE6
                movea.w #(byte_FF8E00-M68K_RAM),a0
                movea.w (a0)+,a1
                move.w  $24(a1),d0
loc_17DDE:                              ; CODE XREF: UI_ProcessTargetingSystem+A8   j
                                        ; UI_ProcessTargetingSystem+AA   j ...
                dbf     d7,loc_17DE8
                move.w  a1,(word_FF801C).w
locret_17DE6:                           ; CODE XREF: UI_ProcessTargetingSystem+8C   j
                rts
; ---------------------------------------------------------------------------
loc_17DE8:                              ; CODE XREF: UI_ProcessTargetingSystem:loc_17DDE   j
                movea.w (a0)+,a2
                cmp.w   $24(a2),d0
                beq.s   loc_17DDE
                bmi.s   loc_17DDE
                movea.w a2,a1
                move.w  $24(a1),d0
                bra.s   loc_17DDE
; End of function UI_ProcessTargetingSystem
; Updates weapon gauge sprite color and animation based on charge level
UI_UpdateWeaponGaugeSprite:                              ; DATA XREF: ROM:0001798E   o  ; was: sub_17DFA
                moveq   #0,d0
                move.w  $10(a1),d0
                cmpi.w  #$3E8,d0
                bmi.s   loc_17E10
                move.l  #dword_19772,(dword_FF802C).w
                bra.s UI_UpdateWeaponGaugePalette
; ---------------------------------------------------------------------------
loc_17E10:                              ; CODE XREF: UI_UpdateWeaponGaugeSprite+A   j
                subq.w  #8,d0
                bpl.s   loc_17E16
                moveq   #0,d0
loc_17E16:                              ; CODE XREF: UI_UpdateWeaponGaugeSprite+18   j
                divs.w  #$80,d0
                asl.w   #2,d0
                andi.w  #$1C,d0
                move.l  -8(a2,d0.w),(dword_FF802C).w
; Updates weapon gauge palette colors with animation cycling
UI_UpdateWeaponGaugePalette:                              ; CODE XREF: UI_UpdateWeaponGaugeSprite+14   j  ; was: loc_17E26
                move.w  (word_FFA000).w,d0
                asl.w   #1,d0
                andi.w  #6,d0
                move.w  word_17E3E(pc,d0.w),(word_FFE36C).w
                move.w  word_17E3E(pc,d0.w),(word_FFE3EC).w
                rts
; End of function UI_UpdateWeaponGaugeSprite
; ---------------------------------------------------------------------------
word_17E3E:     dc.w $EEE, $EA6, $ECC, $E44
                                        ; DATA XREF: UI_UpdateWeaponGaugeSprite+36   r
                                        ; UI_UpdateWeaponGaugeSprite+3C   r


; Loads weapon icon graphics via DMA
Gfx_LoadWeaponIcon:                              ; DATA XREF: ROM:00017990   o  ; was: sub_17E46
                tst.l   (dword_FF8020).w
                bne.s   loc_17E4E
locret_17E4C:                           ; CODE XREF: Gfx_LoadWeaponIcon+10   j
                rts
; ---------------------------------------------------------------------------
loc_17E4E:                              ; CODE XREF: Gfx_LoadWeaponIcon+4   j
                move.w  (word_FF801C).w,d0
                cmpi.w  #$20,d0 ; ' '
                bpl.s   locret_17E4C
                addq.w  #2,(word_FF801C).w
                andi.w  #$1E,d0
                tst.w   (word_FFA22A).w
                beq.s Gfx_LoadWeaponIconTiles
                addi.w  #$20,d0 ; ' '
; Loads weapon icon tile graphics to VRAM using DMA transfer
Gfx_LoadWeaponIconTiles:                              ; CODE XREF: Gfx_LoadWeaponIcon+1E   j  ; was: loc_17E6A
                move.w  word_17E98(pc,d0.w),(word_FFE36C).w
                move.w  word_17E98(pc,d0.w),(word_FFE3EC).w
                lsr.w   #1,d0
                andi.w  #$E,d0
                movea.l (dword_FF8020).w,a0
                move.w  $20(a0,d0.w),(word_FF801E).w
                asl.w   #1,d0
                move.l  (a0,d0.w),d0
                move.l  #$94009340,d1
                jmp Gfx_SetupVDPDMA
; End of function Gfx_LoadWeaponIcon
; ---------------------------------------------------------------------------
word_17E98:     dc.w $EEE, $CEE, $AEE, $8EC, $6EC, $4EA, $2EA, $2E8, $2E8, $E6, $E6, $E4, $E4, $E2, $E2, $C0
                                        ; DATA XREF: Gfx_LoadWeaponIcon:loc_17E6A   r
                                        ; Gfx_LoadWeaponIcon+2A   r
                dc.w $EEE, $EEC, $EEA, $8CE, $6CE, $4AE, $2AE, $28E, $28E, $6E, $6E, $4E, $4E, $2E, $2E, $C


; Renders player sprite with position adjustments
