; Main Madam Barbar boss handler checking defeat and state dispatch
Boss_MadamBarbarMain:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_3A47C
                tst.w   4(a5)
                beq.w   loc_3A4D4
                tst.w   8(a5)
                beq.s   loc_3A4D4
                btst    #2,(byte_FF80EC).w
                bne.s   loc_3A4C2
                btst    #1,(byte_FF80EC).w
                bne.s   loc_3A4C2
                tst.w   (word_FF8200).w
                bne.s   loc_3A4C2
                move.b  #1,(byte_FF830E).w
                bset    #0,(byte_FFA272).w
                move.b  #2,(byte_FF80EC).w
                jsr     (Sprite_ClearObjectFlags).l
                move.w  #4,(word_FF808C).w
                bra.w   loc_3A682
; ---------------------------------------------------------------------------
loc_3A4C2:                                              ; CODE XREF: Boss_MadamBarbarMain+14   j
                                        ; Boss_MadamBarbarMain+1C   j
                jsr     (Gfx_InitPaletteFade).l
                move.w  (dword_FFA900).w,d0
                add.w   $10(a5),d0
                move.w  d0,$BC(a5)
loc_3A4D4:                                              ; CODE XREF: Boss_MadamBarbarMain+4   j
                                        ; Boss_MadamBarbarMain+C   j
                move.w  4(a5),d0
                movea.w off_3A4E4(pc,d0.w),a0
                adda.l  #Boss_MadamBarbarInit,a0
                jmp     (a0)
; End of function Boss_MadamBarbarMain
; ---------------------------------------------------------------------------
off_3A4E4:      dc.w    Boss_MadamBarbarInit-Boss_MadamBarbarInit
                                        ; DATA XREF: Boss_MadamBarbarMain+5C   r
                dc.w    Boss_MadamBarbarSetup-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarIntro-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarIntro_Sequence-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAttackPhase-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAttack_MainPhase-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarDefeatSequence-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAIState-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAI_RightSideAttack-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAI_LeftSideAttack-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAI_CenterSpinAttack-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarAI_DropProjectileAttack-Boss_MadamBarbarInit
                dc.w    Boss_MadamBarbarIdleUpdate-Boss_MadamBarbarInit

; Initializes Madam Barbar boss clearing sprites and setting flags
Boss_MadamBarbarInit:                                   ; DATA XREF: Boss_MadamBarbarMain+60   o  ; was: sub_3A4FE
                                        ; ROM:off_3A4E4   o
                addq.w  #2,4(a5)
                clr.w   8(a5)
                move.w  #$118,d0
                move.w  #$12C,d1
                jsr     (Object_ClearAllExceptTypes).l
                move.b  #1,(byte_FF830E).w
locret_3A51A:                                           ; CODE XREF: Boss_MadamBarbarSetup+4   j
                rts
; End of function Boss_MadamBarbarInit
; Sets up Madam Barbar boss metasprites tiles and animation
Boss_MadamBarbarSetup:                                  ; DATA XREF: ROM:0003A4E6   o  ; was: sub_3A51C
                tst.w   (word_FFF720).w
                bmi.s   locret_3A51A
                addq.w  #1,8(a5)
                movea.w a5,a4
                move.w  #$300,(dword_FF8040).w
                moveq   #$1C,d7
                movea.l #Boss_MadamBarbarMetaspriteDescriptors,a0
                movea.l #Boss_MadamBarbarPartRadii,a1
                movea.l #Boss_MadamBarbarPartLinks,a2
                jsr     (Sprite_InitMetaspriteComplex).l
                bset    #0,$962(a5)
                bset    #0,$9C2(a5)
                bset    #0,$A22(a5)
                bset    #0,$A82(a5)
                moveq   #7,d0
                bset    d0,$18E(a5)
                bset    d0,$1EE(a5)
                bset    d0,$24E(a5)
                bset    d0,$3CE(a5)
                bset    d0,$42E(a5)
                bset    d0,$48E(a5)
                addq.w  #2,4(a5)
                move.w  #$118,(a5)
                move.w  #$CD00,2(a5)
                movea.w #(word_FF9800-M68K_RAM),a0
                move.l  a0,8(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.b  #$20,$20(a5)                    ; ' '
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  #$3A9,(a0)
                move.w  #$100,2(a0)
                move.w  #$8BA9,6(a0)
                move.w  #$100,8(a0)
                move.w  #1,$17E(a5)
                move.w  #$248,$9D0(a5)
                movea.l #Boss_MadamBarbarObjectInitTable,a1
                jsr     (Object_InitGroupFromTable).l
                movea.l #word_3A5F2,a0
                jsr     (Gfx_LoadCompressedTiles).l
                bsr.w   Boss_MadamBarbarSetCollision
                bsr.w   Boss_MadamBarbarWobble
                lea     word_3B20E(pc),a0
                nop
                bsr.w   Boss_MadamBarbarLoadFrameDelays
                bra.s   Boss_MadamBarbarIntro
; End of function Boss_MadamBarbarSetup
; ---------------------------------------------------------------------------
word_3A5F2:     dc.w    $6100, $2000, $302, $2021, $2223, $2425, $2627, $28, $2900
                                        ; DATA XREF: Boss_MadamBarbarSetup+B6   o

; Boss introduction sequence checking position for battle start
Boss_MadamBarbarIntro:                                  ; CODE XREF: Boss_MadamBarbarSetup+D4   j  ; was: sub_3A604
                                        ; DATA XREF: ROM:0003A4E8   o
                tst.w   $17E(a5)
                bpl.w   loc_3A830
                move.w  #3,$17E(a5)
                cmpi.w  #$5C0,$BC(a5)
                bpl.w   loc_3A830
                addq.w  #2,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #7,$17E(a5)
; Madam Barbar intro sequence with victory check
Boss_MadamBarbarIntro_Sequence:                         ; DATA XREF: ROM:0003A4EA   o  ; was: loc_3A640
                tst.w   $17E(a5)
                bpl.s   loc_3A65C
                addq.w  #2,4(a5)
                moveq   #6,d0
                jsr     (UI_CheckVictoryCondition).l
                move.b  #$8A,d0
                jsr     (Input_CheckButtonMode).l
loc_3A65C:                                              ; CODE XREF: Boss_MadamBarbarIntro+40   j
                                        ; Boss_MadamBarbarAttackPhase+8   j
                lea     dword_3B1B2(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bra.w   Boss_MadamBarbarUpdateParts
; End of function Boss_MadamBarbarIntro
; Boss attack phase with timer countdown and collision enabling
Boss_MadamBarbarAttackPhase:                            ; DATA XREF: ROM:0003A4EC   o  ; was: sub_3A66A
                bsr.w   Boss_MadamBarbarSpawnProjectile
                tst.w   (word_FF80C2).w
                bne.s   loc_3A65C
                clr.b   (byte_FF80EC).w
                subi.w  #$A0,(word_FFA970).w
                bra.w   loc_3A780
; ---------------------------------------------------------------------------
loc_3A682:                                              ; CODE XREF: Boss_MadamBarbarMain+42   j
                move.w  #$A,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$11F,$11C(a5)
                move.w  #$48,(word_FF809E).w            ; 'H'
; Madam Barbar main attack with bullet spawning
Boss_MadamBarbarAttack_MainPhase:                       ; DATA XREF: ROM:0003A4EE   o  ; was: loc_3A6AE
                subq.w  #1,$11C(a5)
                bpl.s   loc_3A6BE
                addq.w  #2,4(a5)
                move.w  #$30,$11C(a5)                   ; '0'
loc_3A6BE:                                              ; CODE XREF: Boss_MadamBarbarAttackPhase+48   j
                bsr.w   Boss_MadamBarbarSpawnBullet
                lea     dword_3B1C6(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bsr.w   Boss_MadamBarbarUpdateParts
                cmpi.w  #$38,$11C(a5)                   ; '8'
                bpl.s   locret_3A6F4
                btst    #0,(word_FFA000+1).w
                bne.w   loc_3A70C
                moveq   #7,d0
                moveq   #$1C,d7
                movea.w a5,a0
loc_3A6E8:                                              ; CODE XREF: Boss_MadamBarbarAttackPhase+86   j
                bset    d0,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3A6E8
locret_3A6F4:                                           ; CODE XREF: Boss_MadamBarbarAttackPhase+6C   j
                rts
; End of function Boss_MadamBarbarAttackPhase
; Boss defeat sequence clearing sprites and disabling collision
Boss_MadamBarbarDefeatSequence:                         ; DATA XREF: ROM:0003A4F0   o  ; was: sub_3A6F6
                subq.w  #1,$11C(a5)
                bpl.s   loc_3A708
                moveq   #0,d0
                move.w  #$12C,d1
                jmp     Object_ClearAllExceptTypes
; ---------------------------------------------------------------------------
loc_3A708:                                              ; CODE XREF: Boss_MadamBarbarDefeatSequence+4   j
                bsr.w   Boss_MadamBarbarUpdateParts
loc_3A70C:                                              ; CODE XREF: Boss_MadamBarbarAttackPhase+74   j
                move.w  #$FEB0,(dword_FFA908).w
                moveq   #7,d0
                moveq   #$1C,d7
                movea.w a5,a0
loc_3A718:                                              ; CODE XREF: Boss_MadamBarbarDefeatSequence+2A   j
                bclr    d0,2(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3A718
                rts
; End of function Boss_MadamBarbarDefeatSequence
; Initialize Madam Barbar idle state with position and timers
Boss_MadamBarbarInitIdleState:                          ; CODE XREF: Boss_MadamBarbarAIState+7A   j  ; was: sub_3A726
                                        ; Boss_MadamBarbarAIState+F6   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$18,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $17E(a5)
; End of function Boss_MadamBarbarInitIdleState
; Update Madam Barbar idle state with projectile spawning
Boss_MadamBarbarIdleUpdate:                             ; DATA XREF: ROM:0003A4FC   o  ; was: sub_3A74A
                tst.w   $17E(a5)
                bpl.s   loc_3A75E
                clr.w   $17E(a5)
                cmpi.w  #$1E0,(word_FF8234).w
                bpl.w   loc_3A776
loc_3A75E:                                              ; CODE XREF: Boss_MadamBarbarIdleUpdate+4   j
                addi.w  #2,(word_FF8234).w
                bsr.w   Boss_MadamBarbarSpawnProjectile
                lea     dword_3B1B2(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bra.w   Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A776:                                              ; CODE XREF: Boss_MadamBarbarIdleUpdate+10   j
                                        ; Boss_MadamBarbarAIState+8A   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
loc_3A780:                                              ; CODE XREF: Boss_MadamBarbarAttackPhase+14   j
                move.w  #$E,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                move.w  #1,$17E(a5)
; End of function Boss_MadamBarbarIdleUpdate
; Boss AI state machine tracking player position and attack patterns
Boss_MadamBarbarAIState:                                ; DATA XREF: ROM:0003A4F2   o  ; was: sub_3A79C
                tst.w   $17E(a5)
                bpl.s   loc_3A7DE
                move.w  (dword_FFFF08).w,d7
                move.w  (dword_FFA410).w,d0
                sub.w   $10(a5),d0
                move.w  d0,d1
                bpl.s   loc_3A7B4
                neg.w   d1
loc_3A7B4:                                              ; CODE XREF: Boss_MadamBarbarAIState+14   j
                cmpi.w  #$70,d1                         ; 'p'
                bpl.s   loc_3A7C6
                andi.w  #$3000,d7
                bne.w   loc_3A8E4
                bra.w   loc_3A9A0
; ---------------------------------------------------------------------------
loc_3A7C6:                                              ; CODE XREF: Boss_MadamBarbarAIState+1C   j
                cmpi.w  #$100,d1
                bpl.s   loc_3A7D4
                andi.w  #$7000,d7
                beq.w   loc_3A9A0
loc_3A7D4:                                              ; CODE XREF: Boss_MadamBarbarAIState+2E   j
                tst.w   d0
                bpl.w   loc_3A868
                bra.w   loc_3A7EC
; ---------------------------------------------------------------------------
loc_3A7DE:                                              ; CODE XREF: Boss_MadamBarbarAIState+4   j
                lea     dword_3B1B2(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bra.w   Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A7EC:                                              ; CODE XREF: Boss_MadamBarbarAIState+3E   j
                move.w  #$10,4(a5)
                clr.w   $58(a5)
                clr.w   6(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #1,$17E(a5)
; Madam Barbar right side attack with debris
Boss_MadamBarbarAI_RightSideAttack:                     ; DATA XREF: ROM:0003A4F4   o  ; was: loc_3A806
                bsr.w   Boss_MadamBarbarSpawnDebris
                tst.w   $17E(a5)
                bpl.s   loc_3A830
                subi.w  #0,(word_FF8234).w
                bmi.w   Boss_MadamBarbarInitIdleState
                move.w  (dword_FFA410).w,d0
                addi.w  #$60,d0                         ; '`'
                cmp.w   $10(a5),d0
                bpl.w   loc_3A776
                move.w  #3,$17E(a5)
loc_3A830:                                              ; CODE XREF: Boss_MadamBarbarIntro+4   j
                                        ; Boss_MadamBarbarIntro+14   j
                lea     dword_3B1EA(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bsr.w   Boss_MadamBarbarPlayRotationSound
                movea.w #(word_FFCF80-M68K_RAM),a0
                cmpi.w  #8,$58(a5)
                beq.s   loc_3A856
                cmpi.w  #$C,$58(a5)
                beq.s   loc_3A856
                movea.w #(byte_FFCFE0-M68K_RAM),a0
loc_3A856:                                              ; CODE XREF: Boss_MadamBarbarAIState+AC   j
                                        ; Boss_MadamBarbarAIState+B4   j
                move.w  #$C8,$14(a0)
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                bra.w   Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A868:                                              ; CODE XREF: Boss_MadamBarbarAIState+3A   j
                move.w  #$12,4(a5)
                clr.w   $58(a5)
                clr.w   6(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #1,$17E(a5)
; Madam Barbar left side attack with rotation
Boss_MadamBarbarAI_LeftSideAttack:                      ; DATA XREF: ROM:0003A4F6   o  ; was: loc_3A882
                bsr.w   Boss_MadamBarbarSpawnDebris
                tst.w   $17E(a5)
                bpl.s   loc_3A8AC
                subi.w  #0,(word_FF8234).w
                bmi.w   Boss_MadamBarbarInitIdleState
                move.w  (dword_FFA410).w,d0
                subi.w  #$60,d0                         ; '`'
                cmp.w   $10(a5),d0
                bmi.w   loc_3A776
                move.w  #3,$17E(a5)
loc_3A8AC:                                              ; CODE XREF: Boss_MadamBarbarAIState+EE   j
                lea     dword_3B1FC(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bsr.w   Boss_MadamBarbarPlayRotationSound
                movea.w #(byte_FFD040-M68K_RAM),a0
                cmpi.w  #4,$58(a5)
                beq.s   loc_3A8D2
                cmpi.w  #$10,$58(a5)
                beq.s   loc_3A8D2
                movea.w #(byte_FFD0A0-M68K_RAM),a0
loc_3A8D2:                                              ; CODE XREF: Boss_MadamBarbarAIState+128   j
                                        ; Boss_MadamBarbarAIState+130   j
                move.w  #$C8,$14(a0)
                move.w  a0,$48(a5)
                move.w  a0,$4A(a5)
                bra.w   Boss_MadamBarbarUpdateParts
; ---------------------------------------------------------------------------
loc_3A8E4:                                              ; CODE XREF: Boss_MadamBarbarAIState+22   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$14,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                clr.w   $11E(a5)
; Madam Barbar center spin attack
Boss_MadamBarbarAI_CenterSpinAttack:                    ; DATA XREF: ROM:0003A4F8   o  ; was: loc_3A908
                bsr.w   Boss_MadamBarbarSpawnDebris
                move.w  $58(a5),d0
                bpl.s   loc_3A91E
                tst.w   (word_FF8234).w
                bmi.w   Boss_MadamBarbarInitIdleState
                bra.w   loc_3A776
; ---------------------------------------------------------------------------
loc_3A91E:                                              ; CODE XREF: Boss_MadamBarbarAIState+174   j
                tst.w   $11E(a5)
                bne.s   loc_3A942
                cmpi.w  #$C,d0
                bne.s   loc_3A942
                subi.w  #$52,(word_FF8234).w            ; 'R'
                addq.w  #1,$11E(a5)
                move.b  #$B2,d0
                jsr     (Sound_PlaySFX).l
                move.w  $58(a5),d0
loc_3A942:                                              ; CODE XREF: Boss_MadamBarbarAIState+186   j
                                        ; Boss_MadamBarbarAIState+18C   j
                move.w  #$86,d1
                cmpi.w  #$C,d0
                bmi.s   loc_3A956
                cmpi.w  #$14,d0
                bpl.s   loc_3A956
                move.w  #$FF,d1
loc_3A956:                                              ; CODE XREF: Boss_MadamBarbarAIState+1AE   j
                                        ; Boss_MadamBarbarAIState+1B4   j
                move.w  d1,$1A6(a5)
                move.w  d1,$3E6(a5)
                move.w  $1DC(a5),d1
                move.w  $1DE(a5),d2
                cmpi.w  #$C,d0
                bmi.s   loc_3A978
                cmpi.w  #$10,d1
                bmi.s   loc_3A982
                subq.w  #4,d1
                subq.w  #4,d2
                bra.s   loc_3A982
; ---------------------------------------------------------------------------
loc_3A978:                                              ; CODE XREF: Boss_MadamBarbarAIState+1CE   j
                cmpi.w  #$60,d1                         ; '`'
                bpl.s   loc_3A982
                addq.w  #4,d1
                addq.w  #4,d2
loc_3A982:                                              ; CODE XREF: Boss_MadamBarbarAIState+1D4   j
                                        ; Boss_MadamBarbarAIState+1DA   j
                andi.w  #$1FE,d1
                andi.w  #$1FE,d2
                move.w  d1,$1DC(a5)
                move.w  d2,$1DE(a5)
                lea     dword_3B1D0(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bra.w   loc_3A9F6
; ---------------------------------------------------------------------------
loc_3A9A0:                                              ; CODE XREF: Boss_MadamBarbarAIState+26   j
                                        ; Boss_MadamBarbarAIState+34   j
                clr.w   $58(a5)
                move.w  #$FFFF,$C(a5)
                move.w  #$16,4(a5)
                move.w  a5,$48(a5)
                move.w  #$CFE0,$4A(a5)
                move.w  #$C8,$9D4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1E,d0
                addq.w  #7,d0
                move.w  d0,$17E(a5)
; Madam Barbar dropping projectile attack
Boss_MadamBarbarAI_DropProjectileAttack:                ; DATA XREF: ROM:0003A4FA   o  ; was: loc_3A9CE
                subi.w  #1,(word_FF8234).w
                bmi.w   Boss_MadamBarbarInitIdleState
                tst.w   $17E(a5)
                bmi.w   loc_3A776
                bsr.w   Boss_MadamBarbarSpawnDropProjectile
                lea     dword_3B1BC(pc),a1
                nop
                bsr.w   Boss_MadamBarbarUpdateAnimation
                bra.w   *+4
; End of function Boss_MadamBarbarAIState
; Updates all boss body parts positions with offset calculations
Boss_MadamBarbarUpdateParts:                            ; CODE XREF: Boss_MadamBarbarIntro+62   j  ; was: sub_3A9F2
                                        ; Boss_MadamBarbarAttackPhase+62   p
                bsr.w   Boss_MadamBarbarRotateInit
loc_3A9F6:                                              ; CODE XREF: Boss_MadamBarbarAIState+200   j
                moveq   #$1B,d7
                jsr     (Sprite_SetMetaspriteTraversalPointers).l
                movea.w #(word_FFC680-M68K_RAM),a0
                moveq   #$24,d0                         ; '$'
                moveq   #$A,d1
                moveq   #5,d7
loc_3AA08:                                              ; CODE XREF: Boss_MadamBarbarUpdateParts+22   j
                add.w   d0,$40(a0)
                add.w   d1,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA08
                moveq   #5,d7
loc_3AA1A:                                              ; CODE XREF: Boss_MadamBarbarUpdateParts+34   j
                sub.w   d0,$40(a0)
                add.w   d1,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA1A
                moveq   #$28,d0                         ; '('
                moveq   #$28,d1                         ; '('
                moveq   #$14,d2
                moveq   #2,d7
loc_3AA32:                                              ; CODE XREF: Boss_MadamBarbarUpdateParts+4C   j
                sub.w   d0,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA32
                moveq   #2,d7
loc_3AA44:                                              ; CODE XREF: Boss_MadamBarbarUpdateParts+5E   j
                sub.w   d1,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA44
                moveq   #2,d7
loc_3AA56:                                              ; CODE XREF: Boss_MadamBarbarUpdateParts+70   j
                add.w   d0,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA56
                moveq   #2,d7
loc_3AA68:                                              ; CODE XREF: Boss_MadamBarbarUpdateParts+82   j
                add.w   d1,$40(a0)
                sub.w   d2,$44(a0)
                lea     $60(a0),a0
                dbf     d7,loc_3AA68
                movea.w a5,a3
                moveq   #$1C,d7
                jsr     (Sprite_UpdateLinkedPositions).l
                bsr.w   Boss_MadamBarbarCheckBounds
; End of function Boss_MadamBarbarUpdateParts
; Applies wobble effect to boss sprite using sine wave
Boss_MadamBarbarWobble:                                 ; CODE XREF: Boss_MadamBarbarSetup+C6   p  ; was: sub_3AA86
                move.w  (word_FFA000).w,d7
                andi.w  #$F,d7
                move.b  byte_3AACE(pc,d7.w),d0
                addq.w  #8,d7
                andi.w  #$F,d7
                move.b  byte_3AACE(pc,d7.w),d1
                move.w  #$24EA,(dword_FF8040).w
                move.w  #$240E,(dword_FF8040+2).w
                sub.b   d0,(dword_FF8040).w
                sub.b   d1,(dword_FF8040+2).w
                asr.b   #1,d0
                asr.b   #1,d1
                add.b   d0,(dword_FF8040+1).w
                sub.b   d1,(dword_FF8040+3).w
                movea.w #(word_FF9800-M68K_RAM),a0
                move.w  (dword_FF8040).w,4(a0)
                move.w  (dword_FF8040+2).w,$A(a0)
                rts
; End of function Boss_MadamBarbarWobble
; ---------------------------------------------------------------------------
byte_3AACE:     dc.b    0, 1, 2, 3, 4, 4, 4, 4, 3, 2, 1, 0, 0, 1, 1, 0
                                        ; DATA XREF: Boss_MadamBarbarWobble+8   r
                                        ; Boss_MadamBarbarWobble+12   r

; Calculate direction to player and set Madam Barbar facing
Boss_MadamBarbarFacePlayer:
                clr.w   $54(a5)                         ; was: sub_3AADE
                jsr     (Physics_GetPlayerDelta).l
                tst.w   d1
                bpl.s   Boss_MadamBarbarSetCollision
                move.w  #$100,$54(a5)
; End of function Boss_MadamBarbarFacePlayer
; Sets collision flags on specific boss body segments
Boss_MadamBarbarSetCollision:                           ; CODE XREF: Boss_MadamBarbarSetup+C2   p  ; was: sub_3AAF2
                                        ; Boss_MadamBarbarFacePlayer+C   j
                moveq   #3,d5
                bclr    d5,$6E(a5)
                bclr    d5,$CE(a5)
                bclr    d5,$12E(a5)
                bclr    d5,$18E(a5)
                bset    d5,$2AE(a5)
                bset    d5,$30E(a5)
                bset    d5,$36E(a5)
                bset    d5,$3CE(a5)
                rts
; End of function Boss_MadamBarbarSetCollision
; Initializes boss rotation animation pointer updates
Boss_MadamBarbarRotateInit:                             ; CODE XREF: Boss_MadamBarbarUpdateParts   p  ; was: sub_3AB16
                movea.w #(byte_FFC7FC-M68K_RAM),a0
                bsr.s   Boss_MadamBarbarRotateUpdate
                movea.w #(word_FFC7FE-M68K_RAM),a0
; End of function Boss_MadamBarbarRotateInit
; Updates boss rotation angle based on frame counter
Boss_MadamBarbarRotateUpdate:                           ; CODE XREF: Boss_MadamBarbarRotateInit+4   p  ; was: sub_3AB20
                btst    #2,(word_FFA000+1).w
                bne.s   loc_3AB3A
                subq.w  #8,(a0)
                cmpi.w  #8,(a0)
                bpl.s   loc_3AB34
                move.w  #8,(a0)
loc_3AB34:                                              ; CODE XREF: Boss_MadamBarbarRotateUpdate+E   j
                                        ; Boss_MadamBarbarRotateUpdate+20   j
                andi.w  #$1FC,(a0)
                rts
; ---------------------------------------------------------------------------
loc_3AB3A:                                              ; CODE XREF: Boss_MadamBarbarRotateUpdate+6   j
                addq.w  #8,(a0)
                cmpi.w  #$20,(a0)                       ; ' '
                bmi.s   loc_3AB34
                move.w  #$20,(a0)                       ; ' '
                andi.w  #$1FC,(a0)
locret_3AB4A:                                           ; CODE XREF: Boss_MadamBarbarPlayRotationSound+4   j
                                        ; Boss_MadamBarbarPlayRotationSound+C   j
                rts
; End of function Boss_MadamBarbarRotateUpdate
; Play rotation sound effect for Madam Barbar based on animation frame
Boss_MadamBarbarPlayRotationSound:                      ; CODE XREF: Boss_MadamBarbarAIState+9E   p  ; was: sub_3AB4C
                                        ; Boss_MadamBarbarAIState+11A   p
                tst.w   $29C(a5)
                beq.s   locret_3AB4A
                btst    #0,7(a5)
                bne.s   locret_3AB4A
                move.b  #$AF,d0
                jmp     (Sound_PlaySFX).l
; End of function Boss_MadamBarbarPlayRotationSound
; Calculates boss screen bounds with camera offset for boundary checking
Boss_MadamBarbarCheckBounds:                            ; CODE XREF: Boss_MadamBarbarUpdateParts+90   p  ; was: sub_3AB64
                move.w  #$BC,d0
                sub.w   $10(a5),d0
                move.w  d0,(dword_FFA908).w
                move.w  $14(a5),d0
                addi.w  #$50,d0                         ; 'P'
                move.w  d0,(dword_FFA90C).w
                jmp     Boss_ClampSharedScreenPosition
; End of function Boss_MadamBarbarCheckBounds
; Spawns boss bullet projectile with random velocity calculation
Boss_MadamBarbarSpawnBullet:                            ; CODE XREF: Boss_MadamBarbarAttackPhase:loc_3A6BE   p  ; was: sub_3AB82
                move.w  #6,(word_FFA010).w
                move.w  #6,(word_FFA014).w
                jsr     (Projectile_UpdateAfterGlobalDelay).l
                bne.s   locret_3ABE2
                jsr     (Sprite_InitTypeA4FromTable).l
                move.b  #0,$20(a0)
                move.w  #1,$1C(a0)
                move.w  (dword_FFFF08+2).w,$1E(a0)
                move.b  (dword_FFFF08).w,d0
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$7F,d0
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$40,d0                         ; '@'
                subi.w  #$1D,d1
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  (dword_FFFF08).w,d0
                ext.l   d0
                asl.l   #2,d0
                move.l  d0,$18(a0)
locret_3ABE2:                                           ; CODE XREF: Boss_MadamBarbarSpawnBullet+12   j
                rts
; End of function Boss_MadamBarbarSpawnBullet
; Updates boss animation sequence with interpolation and body part rotation
Boss_MadamBarbarUpdateAnimation:                        ; CODE XREF: Boss_MadamBarbarIntro+5E   p  ; was: sub_3ABE4
                                        ; Boss_MadamBarbarAttackPhase+5E   p
                clr.w   $29C(a5)
                tst.w   $C(a5)
                bpl.s   loc_3AC6A
loc_3ABEE:                                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+4A   j
                move.w  $58(a5),d0
                bmi.w   loc_3AC7A
                cmpi.b  #$80,(a1,d0.w)
                bne.s   loc_3AC10
                move.b  1(a1,d0.w),d0
                jsr     (Sound_PlaySFX).l
                addq.w  #2,$58(a5)
                move.w  $58(a5),d0
loc_3AC10:                                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+18   j
                move.w  (a1,d0.w),d3
                cmpi.w  #$FFFE,d3
                bne.s   loc_3AC20
                move.w  d3,$58(a5)
                rts
; ---------------------------------------------------------------------------
loc_3AC20:                                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+34   j
                cmpi.w  #$FFFF,d3
                bne.s   loc_3AC30
                clr.w   $58(a5)
                clr.w   6(a5)
                bra.s   loc_3ABEE
; ---------------------------------------------------------------------------
loc_3AC30:                                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+40   j
                move.w  d3,(dword_FF8040).w
                andi.w  #$FF,d3
                move.w  2(a1,d0.w),d0
                ext.l   d0
                addi.l  #word_3B20E,d0
                movea.l d0,a0
                bsr.w   Boss_MadamBarbarCalcDeltas
                move.b  (dword_FF8040).w,d1
                ext.w   d1
                add.w   d1,$C(a5)
                addq.w  #4,$58(a5)
                addq.w  #1,6(a5)
                addq.w  #1,$29C(a5)
                subq.w  #1,$17E(a5)
                tst.w   $C(a5)
                bmi.s   loc_3AC7A
loc_3AC6A:                                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+8   j
                subq.w  #1,$C(a5)
                movea.w #(dword_FF9400-M68K_RAM),a0
                moveq   #$B,d7
                jsr     (Anim_ApplyInterpolationStep).l
loc_3AC7A:                                              ; CODE XREF: Boss_MadamBarbarUpdateAnimation+E   j
                                        ; Boss_MadamBarbarUpdateAnimation+84   j
                move.w  #$1FE,d7
                movea.w #(dword_FF9400-M68K_RAM),a0
                move.b  (a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$B6(a5)
                move.b  4(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$116(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$176(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$1D6(a5)
                move.w  $1DC(a5),d2
                move.w  d2,d1
                neg.w   d1
                add.w   d0,d2
                add.w   d0,d1
                and.w   d7,d1
                and.w   d7,d1
                move.w  d2,$236(a5)
                move.w  d1,$296(a5)
                move.b  8(a0),d0
                asl.w   #1,d0
                and.w   d7,d0
                move.w  d0,$2F6(a5)
                move.b  $C(a0),d1
                asl.w   #1,d1
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$356(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$3B6(a5)
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$416(a5)
                move.w  $1DE(a5),d2
                move.w  d2,d1
                neg.w   d1
                add.w   d0,d2
                add.w   d0,d1
                and.w   d7,d1
                and.w   d7,d1
                move.w  d2,$476(a5)
                move.w  d1,$4D6(a5)
                move.b  $10(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$536(a5)
                move.w  d1,$596(a5)
                move.b  $14(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$5F6(a5)
                move.w  d0,$9B6(a5)
                move.b  $18(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$656(a5)
                move.w  d1,$6B6(a5)
                move.b  $1C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$716(a5)
                move.w  d0,$A16(a5)
                move.b  $20(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$776(a5)
                move.w  d1,$7D6(a5)
                move.b  $24(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$836(a5)
                move.w  d0,$A76(a5)
                move.b  $28(a0),d1
                asl.w   #1,d1
                and.w   d7,d1
                move.w  d1,$896(a5)
                move.w  d1,$8F6(a5)
                move.b  $2C(a0),d0
                asl.w   #1,d0
                add.w   d1,d0
                and.w   d7,d0
                move.w  d0,$956(a5)
                move.w  d0,$AD6(a5)
                rts
; End of function Boss_MadamBarbarUpdateAnimation
; Calculates interpolation deltas for smooth boss animation transitions
Boss_MadamBarbarCalcDeltas:                             ; CODE XREF: Boss_MadamBarbarUpdateAnimation+62   p  ; was: sub_3AD8E
                lea     (Boss_MadamBarbarNeutralPose).l,a1
                movea.w #(dword_FF9400-M68K_RAM),a2
                move.w  d3,$C(a5)
                moveq   #$B,d7
                jmp     Anim_CalculateInterpolationDeltas
; End of function Boss_MadamBarbarCalcDeltas
; Loads frame delay values for boss animation timing
Boss_MadamBarbarLoadFrameDelays:                        ; CODE XREF: Boss_MadamBarbarSetup+D0   p  ; was: sub_3ADA4
                movea.w #(dword_FF9400-M68K_RAM),a1
                moveq   #$B,d7
                jmp     Anim_LoadFrameDelays
; End of function Boss_MadamBarbarLoadFrameDelays
; Spawns debris projectiles with random velocity and trajectory
Boss_MadamBarbarSpawnDebris:                            ; CODE XREF: Boss_MadamBarbarAIState:loc_3A806   p  ; was: sub_3ADB0
                                        ; sub_3A79C:loc_3A882   p
                move.w  (word_FFA000).w,d0
                andi.w  #$3F,d0                         ; '?'
                bne.s   locret_3AE34
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   locret_3AE34
                move.w  #$120,(a0)
                clr.w   4(a0)
                move.w  #$8D00,2(a0)
                move.w  #$F3B3,$E(a0)
                move.w  #$A00,8(a0)
                move.w  #$F4F4,$A(a0)
                move.b  #4,$20(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                subq.w  #1,$14(a0)
                move.b  #$80,$21(a0)
                move.l  #$F40CF40C,$28(a0)
                move.w  #$20,$48(a0)                    ; ' '
                clr.w   $4A(a0)
                moveq   #3,d0
                swap    d0
                btst    #4,(dword_FFFF08).w
                beq.s   loc_3AE22
                neg.l   d0
loc_3AE22:                                              ; CODE XREF: Boss_MadamBarbarSpawnDebris+6E   j
                move.l  d0,$4C(a0)
                asr.l   #1,d0
                move.l  d0,$18(a0)
                move.l  #$18000,$1C(a0)
locret_3AE34:                                           ; CODE XREF: Boss_MadamBarbarSpawnDebris+8   j
                                        ; Boss_MadamBarbarSpawnDebris+14   j
                rts
; End of function Boss_MadamBarbarSpawnDebris
; Debris projectile physics with gravity bounce and screen bounds
