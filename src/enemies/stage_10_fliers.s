Enemy_Stage10FlyMain:                                   ; DATA XREF: ROM:off_5DC   o  ; was: sub_2DF7E
                move.w  4(a5),d0
                lea     off_2DF8A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10FlyMain
; ---------------------------------------------------------------------------
off_2DF8A:      dc.w    Enemy_Stage10FlyInit-*          ; DATA XREF: Enemy_Stage10FlyMain+4   o
                dc.w    Enemy_Stage10FlyInit_GravityAccel-*

; Initializes Stage 10 fly enemy with physics
Enemy_Stage10FlyInit:                                   ; DATA XREF: ROM:off_2DF8A   o  ; was: sub_2DF8E
                move.w  #$8F00,2(a5)
                move.w  #$44C8,$E(a5)
                move.w  #$500,8(a5)
                move.w  #$F8F8,$A(a5)
                move.b  #$80,$21(a5)
                move.b  #$80,$23(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F808F808,$28(a5)
                addq.w  #2,4(a5)
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   Enemy_Stage10FlyInit_GravityAccel
                ori.w   #$8000,$E(a5)
; Applies gravity acceleration to projectile movement
Enemy_Stage10FlyInit_GravityAccel:                      ; CODE XREF: Enemy_Stage10FlyInit+3E   j  ; was: loc_2DFD4
                                        ; DATA XREF: ROM:0002DF8C   o
                addi.l  #$2000,$1C(a5)
                bclr    #6,$22(a5)
                bne.s   loc_2E032
                bclr    #7,$22(a5)
                bne.s   loc_2E032
                cmpi.w  #$1B8,(word_FFDB20).w
                bne.s   loc_2E024
                move.w  (dword_FFDB34).w,d0
                subq.w  #8,d0
                cmp.w   $14(a5),d0
                bhi.s   loc_2E018
                move.w  (dword_FFDB30).w,d0
                cmp.w   $10(a5),d0
                bhi.s   loc_2E018
                move.w  (dword_FFDB30).w,d0
                addi.w  #$100,d0
                cmp.w   $10(a5),d0
                bcc.s   loc_2E032
loc_2E018:                                              ; CODE XREF: Enemy_Stage10FlyInit+70   j
                                        ; Enemy_Stage10FlyInit+7A   j
                cmpi.w  #$150,$14(a5)
                blt.s   locret_2E046
                bra.w   loc_2E416
; ---------------------------------------------------------------------------
loc_2E024:                                              ; CODE XREF: Enemy_Stage10FlyInit+64   j
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                move.w  d2,d2
                beq.s   locret_2E046
loc_2E032:                                              ; CODE XREF: Enemy_Stage10FlyInit+54   j
                                        ; Enemy_Stage10FlyInit+5C   j
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.w  #$C8,$26(a5)
                jmp     Projectile_CheckLifetime
; ---------------------------------------------------------------------------
locret_2E046:                                           ; CODE XREF: Enemy_Stage10FlyInit+90   j
                                        ; Enemy_Stage10FlyInit+A2   j
                rts
; End of function Enemy_Stage10FlyInit
; Initializes Stage 10 wasp enemy sprite
Enemy_Stage10WaspInit:                                  ; CODE XREF: Enemy_Stage10WaspState1+2   p  ; was: sub_2E048
                move.w  #$EF00,2(a5)
                move.w  (word_FF8278).w,d1
                or.w    (word_FF808A).w,d1
                move.w  d1,$E(a5)
                move.b  #$48,$20(a5)                    ; 'H'
                move.b  #$C0,$21(a5)
                move.l  #$FC04FC04,$2C(a5)
                move.l  #$F010F010,$28(a5)
                lea     word_2E096(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                rts
; End of function Enemy_Stage10WaspInit
; ---------------------------------------------------------------------------
word_2E096:     dc.w    $1806, $1100                    ; DATA XREF: Enemy_Stage10WaspInit+2E   o

; Updates animation frame from table
Enemy_UpdateAnimationFrame:                             ; CODE XREF: Enemy_Stage10WaspMain+58   p  ; was: sub_2E09A
                move.w  $5C(a5),d0
                beq.s   locret_2E0AC
                subq.w  #4,d0
                move.l  off_2E0AE(pc,d0.w),8(a5)
                clr.w   $C(a5)
locret_2E0AC:                                           ; CODE XREF: Enemy_UpdateAnimationFrame+4   j
                rts
; End of function Enemy_UpdateAnimationFrame
; ---------------------------------------------------------------------------
off_2E0AE:      dc.l    off_EB278                       ; DATA XREF: Enemy_UpdateAnimationFrame+8   r
                dc.l    off_EB294
                dc.l    off_EB2B4
                dc.l    off_EB2CC

; Main handler for Stage 10 wasp enemy
Enemy_Stage10WaspMain:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E0BE
                tst.w   4(a5)
                beq.s   Enemy_WaspMainLoop
                tst.w   $24(a5)
                bmi.w   Enemy_Stage10WaspDeath
                tst.w   (word_FF808C).w
                bpl.w   Enemy_Stage10WaspDeath
                bclr    #7,$22(a5)
                beq.s   loc_2E10A
                btst    #4,$22(a5)
                bne.w   Enemy_Stage10WaspDeath
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp     Enemy_GetEntityAddress
; ---------------------------------------------------------------------------
loc_2E10A:                                              ; CODE XREF: Enemy_Stage10WaspMain+1C   j
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Main loop for wasp enemy dispatching state and updating animation
Enemy_WaspMainLoop:                                     ; CODE XREF: Enemy_Stage10WaspMain+4   j  ; was: loc_2E114
                bsr.s   Enemy_Stage10WaspDispatcher
                bsr.w   Enemy_UpdateAnimationFrame
                bra.w   Enemy_UpdateSpriteFlip
; End of function Enemy_Stage10WaspMain
; State dispatcher for wasp enemy
Enemy_Stage10WaspDispatcher:                            ; CODE XREF: Enemy_Stage10WaspMain:loc_2E114   p  ; was: sub_2E11E
                clr.w   $5C(a5)
                move.w  4(a5),d0
                lea     off_2E12E(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10WaspDispatcher
; ---------------------------------------------------------------------------
off_2E12E:      dc.w    Enemy_Stage10WaspState1-*       ; DATA XREF: Enemy_Stage10WaspDispatcher+8   o
                dc.w    Enemy_Stage10WaspState2-*
                dc.w    Enemy_Stage10WaspState3-*
                dc.w    Enemy_Stage10WaspState4-*
                dc.w    Enemy_Stage10WaspState5-*
                dc.w    Enemy_WaspLoopTimer-*

; Wasp state 1 initialization
Enemy_Stage10WaspState1:                                ; DATA XREF: ROM:off_2E12E   o  ; was: sub_2E13A
                moveq   #0,d0
                bsr.w   Enemy_Stage10WaspInit
                move.w  #$C,$5C(a5)
                addq.w  #2,4(a5)
                move.w  #3,$4A(a5)
                move.w  #3,$4C(a5)
                btst    #0,$5F(a5)
                bne.s   loc_2E166
                move.w  #$1E0,$10(a5)
                rts
; ---------------------------------------------------------------------------
loc_2E166:                                              ; CODE XREF: Enemy_Stage10WaspState1+22   j
                move.w  #$70,$10(a5)                    ; 'p'
                rts
; End of function Enemy_Stage10WaspState1
; Wasp state 2 flight with physics
Enemy_Stage10WaspState2:                                ; DATA XREF: ROM:0002E130   o  ; was: sub_2E16E
                jsr     (Physics_EntityWallCheck).l
                btst    #7,$1C(a5)
                bne.s   loc_2E18A
                jsr     (Player_ActionDispatcher).l
                btst    #0,6(a5)
                bne.s   Enemy_WaspTransitionToWait
loc_2E18A:                                              ; CODE XREF: Enemy_Stage10WaspState2+C   j
                jsr     (Physics_TerrainCheckWithVelocity).l
                addi.l  #$4000,$1C(a5)
                rts
; ---------------------------------------------------------------------------
; Transitions wasp to waiting state with hover configuration
Enemy_WaspTransitionToWait:                             ; CODE XREF: Enemy_Stage10WaspState2+1A   j  ; was: loc_2E19A
                clr.l   $18(a5)
                move.w  #$10,$5C(a5)
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10WaspState2
; Wasp state 3 delay timer
Enemy_Stage10WaspState3:                                ; DATA XREF: ROM:0002E132   o  ; was: sub_2E1B0
                subq.w  #1,$48(a5)
                bne.s   locret_2E1C6
                tst.w   $4C(a5)
                beq.s   loc_2E1C2
                subq.w  #1,$4A(a5)
                beq.s   loc_2E1C8
loc_2E1C2:                                              ; CODE XREF: Enemy_Stage10WaspState3+A   j
                addq.w  #2,4(a5)
locret_2E1C6:                                           ; CODE XREF: Enemy_Stage10WaspState3+4   j
                rts
; ---------------------------------------------------------------------------
loc_2E1C8:                                              ; CODE XREF: Enemy_Stage10WaspState3+10   j
                move.w  #4,$5C(a5)
                move.w  #$20,$48(a5)                    ; ' '
                addq.w  #6,4(a5)
                rts
; End of function Enemy_Stage10WaspState3
; Wasp state 4 animation setup
Enemy_Stage10WaspState4:                                ; DATA XREF: ROM:0002E134   o  ; was: sub_2E1DA
                move.w  #8,$5C(a5)
                move.w  #$A,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10WaspState4
; Wasp state 5 attack dive
Enemy_Stage10WaspState5:                                ; DATA XREF: ROM:0002E136   o  ; was: sub_2E1EC
                subq.w  #1,$48(a5)
                bne.s   locret_2E22A
                subq.w  #6,4(a5)
                jsr     (Physics_CalculateDistanceTo).l
                tst.w   d1
                bpl.s   loc_2E20A
                move.l  #$FFFE0000,$18(a5)
                bra.s   loc_2E212
; ---------------------------------------------------------------------------
loc_2E20A:                                              ; CODE XREF: Enemy_Stage10WaspState5+12   j
                move.l  #$20000,$18(a5)
loc_2E212:                                              ; CODE XREF: Enemy_Stage10WaspState5+1C   j
                move.w  #$C,$5C(a5)
                move.l  #$FFFA0000,$1C(a5)
                tst.w   $4C(a5)
                bne.s   locret_2E22A
                neg.l   $18(a5)
locret_2E22A:                                           ; CODE XREF: Enemy_Stage10WaspState5+4   j
                                        ; Enemy_Stage10WaspState5+38   j
                rts
; End of function Enemy_Stage10WaspState5
; Wasp enemy loop timer that decrements counters and loops state
Enemy_WaspLoopTimer:                                    ; DATA XREF: ROM:0002E138   o  ; was: sub_2E22C
                subq.w  #1,$48(a5)
                bpl.s   locret_2E240
                subq.w  #1,$4C(a5)
                move.w  #3,$4A(a5)
                subq.w  #4,4(a5)
locret_2E240:                                           ; CODE XREF: Enemy_WaspLoopTimer+4   j
                rts
; End of function Enemy_WaspLoopTimer
; Handles wasp enemy death
Enemy_Stage10WaspDeath:                                 ; CODE XREF: Enemy_Stage10WaspMain+A   j  ; was: sub_2E242
                                        ; Enemy_Stage10WaspMain+12   j
                move.w  #$2C4,(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #off_EB2B4,8(a5)
                clr.w   $C(a5)
                move.w  #$10,$48(a5)
                move.l  #$FFFB2000,$1C(a5)
                move.l  #$FFFEA000,$18(a5)
                btst    #3,$E(a5)
                beq.s   locret_2E280
                neg.l   $18(a5)
locret_2E280:                                           ; CODE XREF: Enemy_Stage10WaspDeath+38   j
                rts
; End of function Enemy_Stage10WaspDeath
; Wasp explosion with gravity and sound
Enemy_Stage10WaspExplode:                               ; DATA XREF: ROM:off_5DC   o  ; was: sub_2E282
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2E2A8
                jsr     (Projectile_ExplodeWithSound).l
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                moveq   #7,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2E2A8:                                              ; CODE XREF: Enemy_Stage10WaspExplode+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2E2BC
                bclr    #7,2(a5)
locret_2E2BC:                                           ; CODE XREF: Enemy_Stage10WaspExplode+32   j
                rts
; End of function Enemy_Stage10WaspExplode
; Initializes Stage 12 floater enemy
