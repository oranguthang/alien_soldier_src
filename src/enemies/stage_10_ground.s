Enemy_Stage10BomberMain:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E6C2
                move.w  #$120,$10(a5)
                move.w  #$154,$14(a5)
                move.w  4(a5),d0
                lea     off_2E6DA(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10BomberMain
; ---------------------------------------------------------------------------
off_2E6DA:      dc.w    Enemy_Stage10BomberInit-*       ; DATA XREF: Enemy_Stage10BomberMain+10   o
                dc.w    Enemy_Stage10BomberSpawn-*
                dc.w    Enemy_Stage10BomberWait-*
                dc.w    Enemy_Stage10BomberComplete-*

; Initializes Stage 10 bomber sprite
Enemy_Stage10BomberInit:                                ; DATA XREF: ROM:off_2E6DA   o  ; was: sub_2E6E2
                move.w  #$D00,2(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10BomberInit
; Spawns bomber projectile at random position
Enemy_Stage10BomberSpawn:                               ; DATA XREF: ROM:0002E6DC   o  ; was: sub_2E6EE
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   locret_2E73A
                jsr     (RandomNumber).l
                move.w  a0,$4C(a5)
                addq.w  #2,4(a5)
                move.w  #$2D4,(a0)
                move.w  $14(a5),$14(a0)
                move.w  $5E(a5),$5E(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #3,d0
                subq.w  #2,d0
                add.w   d0,$14(a0)
                move.b  (dword_FFFF08).w,d0
                andi.b  #1,d0
                beq.s   Enemy_BomberSetSpawnX
                move.w  #$1C8,$10(a0)
                rts
; ---------------------------------------------------------------------------
; Sets bomber enemy spawn X position based on random flag
Enemy_BomberSetSpawnX:                                  ; CODE XREF: Enemy_Stage10BomberSpawn+3C   j  ; was: loc_2E734
                move.w  #$78,$10(a0)                    ; 'x'
locret_2E73A:                                           ; CODE XREF: Enemy_Stage10BomberSpawn+6   j
                rts
; End of function Enemy_Stage10BomberSpawn
; Waits for spawned projectile destruction
Enemy_Stage10BomberWait:                                ; DATA XREF: ROM:0002E6DE   o  ; was: sub_2E73C
                movea.w $4C(a5),a0
                cmpi.w  #$2D4,(a0)
                beq.s   locret_2E750
                move.w  #$40,$48(a5)                    ; '@'
                addq.w  #2,4(a5)
locret_2E750:                                           ; CODE XREF: Enemy_Stage10BomberWait+8   j
                rts
; End of function Enemy_Stage10BomberWait
; Completes bomber sequence
Enemy_Stage10BomberComplete:                            ; DATA XREF: ROM:0002E6E0   o  ; was: sub_2E752
                subq.w  #1,$48(a5)
                bne.s   locret_2E766
                cmpi.w  #$1B8,(word_FFDB20).w
                beq.s   loc_2E768
                move.w  #2,4(a5)
locret_2E766:                                           ; CODE XREF: Enemy_Stage10BomberComplete+4   j
                rts
; ---------------------------------------------------------------------------
loc_2E768:                                              ; CODE XREF: Enemy_Stage10BomberComplete+C   j
                bset    #4,2(a5)
                rts
; End of function Enemy_Stage10BomberComplete
; Initializes Stage 10 beetle enemy sprite
Enemy_Stage10BeetleInit:                                ; CODE XREF: Enemy_Stage10BeetleState1+2   p  ; was: sub_2E770
                move.w  #$EF00,2(a5)
                moveq   #0,d1
                ori.w   #$8000,d1
                move.w  d1,$E(a5)
                move.b  #0,$20(a5)
                move.b  #$80,$21(a5)
                move.l  #$FE02FE02,$2C(a5)
                move.l  #$F010F010,$28(a5)
                lea     word_2E7C8(pc),a0
                nop
                moveq   #0,d1
                move.b  (a0,d0.w),$27(a5)
                move.b  1(a0,d0.w),$25(a5)
                move.b  2(a0,d0.w),d1
                asl.w   #4,d1
                move.w  d1,$5A(a5)
                move.l  #off_1A0F42,8(a5)
                clr.w   $C(a5)
                rts
; End of function Enemy_Stage10BeetleInit
; ---------------------------------------------------------------------------
word_2E7C8:     dc.w    $1804, $1100                    ; DATA XREF: Enemy_Stage10BeetleInit+2C   o

; Main handler for Stage 10 beetle enemy
Enemy_Stage10BeetleMain:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E7CC
                tst.w   4(a5)
                beq.s   Enemy_BeetleMainLoop
                tst.w   $24(a5)
                bmi.w   Enemy_Stage10BeetleDefeat
                tst.w   (word_FF808C).w
                bpl.w   Enemy_Stage10BeetleDefeat
                jsr     (RandomNumber).l
                clr.w   6(a5)
; Main loop for beetle enemy with state dispatch and animation
Enemy_BeetleMainLoop:                                   ; CODE XREF: Enemy_Stage10BeetleMain+4   j  ; was: loc_2E7EC
                bsr.s   Enemy_Stage10BeetleDispatcher
                bsr.w   Enemy_UpdateSpriteFlip
                tst.l   $1C(a5)
                bne.s   locret_2E804
                move.l  #off_1A0F42,8(a5)
                clr.w   $C(a5)
locret_2E804:                                           ; CODE XREF: Enemy_Stage10BeetleMain+2A   j
                rts
; End of function Enemy_Stage10BeetleMain
; State dispatcher for beetle enemy
Enemy_Stage10BeetleDispatcher:                          ; CODE XREF: Enemy_Stage10BeetleMain:loc_2E7EC   p  ; was: sub_2E806
                move.w  4(a5),d0
                lea     off_2E812(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Enemy_Stage10BeetleDispatcher
; ---------------------------------------------------------------------------
off_2E812:      dc.w    Enemy_Stage10BeetleState1-*     ; DATA XREF: Enemy_Stage10BeetleDispatcher+4   o
                dc.w    Enemy_BeetleWalkState-*
                dc.w    Enemy_Stage10BeetleState2-*
                dc.w    Enemy_BeetleFallAndLand-*
                dc.w    Enemy_BeetleFallOffscreen-*

; Beetle state 1 initialization with delay
Enemy_Stage10BeetleState1:                              ; DATA XREF: ROM:off_2E812   o  ; was: sub_2E81C
                moveq   #0,d0
                bsr.w   Enemy_Stage10BeetleInit
                addq.w  #2,4(a5)
                move.w  #$40,$48(a5)                    ; '@'
                cmpi.w  #$120,$10(a5)
                bcc.s   loc_2E83C
                move.w  #1,$18(a5)
                bra.s   Enemy_BeetleWalkState
; ---------------------------------------------------------------------------
loc_2E83C:                                              ; CODE XREF: Enemy_Stage10BeetleState1+16   j
                move.w  #$FFFF,$18(a5)
; Beetle walking state with timer countdown and delay lookup
Enemy_BeetleWalkState:                                  ; CODE XREF: Enemy_Stage10BeetleState1+1E   j  ; was: loc_2E842
                                        ; DATA XREF: ROM:0002E814   o
                subq.w  #1,$48(a5)
                bne.s   locret_2E85A
                clr.w   $4C(a5)
                bsr.w   Enemy_Stage10BeetleDelayTable
                move.w  #$100,$4E(a5)
                addq.w  #2,4(a5)
locret_2E85A:                                           ; CODE XREF: Enemy_Stage10BeetleState1+2A   j
                rts
; End of function Enemy_Stage10BeetleState1
; Beetle state 2 movement pattern
Enemy_Stage10BeetleState2:                              ; DATA XREF: ROM:0002E816   o  ; was: sub_2E85C
                btst    #0,$5F(a5)
                beq.s   loc_2E86A
                subq.w  #1,$4E(a5)
                beq.s   loc_2E892
loc_2E86A:                                              ; CODE XREF: Enemy_Stage10BeetleState2+6   j
                subq.w  #1,$48(a5)
                bne.s   locret_2E890
                bsr.w   Enemy_Stage10BeetleDelayTable
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                add.w   d0,d0
                lea     (Math_SineTable).l,a1
                move.w  (a1,d0.w),d0
                ext.l   d0
                asl.l   #3,d0
                move.l  d0,$18(a5)
locret_2E890:                                           ; CODE XREF: Enemy_Stage10BeetleState2+12   j
                rts
; ---------------------------------------------------------------------------
loc_2E892:                                              ; CODE XREF: Enemy_Stage10BeetleState2+C   j
                clr.l   $18(a5)
                move.l  #$FFFB8000,$1C(a5)
                move.w  #3,$4A(a5)
                addq.w  #2,4(a5)
                rts
; End of function Enemy_Stage10BeetleState2
; Gets delay value from timing table
Enemy_Stage10BeetleDelayTable:                          ; CODE XREF: Enemy_Stage10BeetleState1+30   p  ; was: sub_2E8AA
                                        ; Enemy_Stage10BeetleState2+14   p
                move.w  $4C(a5),d0
                move.w  word_2E8C6(pc,d0.w),$48(a5)
                addq.w  #2,$4C(a5)
                cmpi.w  #$20,$4C(a5)                    ; ' '
                bcs.s   locret_2E8C4
                clr.w   $4C(a5)
locret_2E8C4:                                           ; CODE XREF: Enemy_Stage10BeetleDelayTable+14   j
                rts
; End of function Enemy_Stage10BeetleDelayTable
; ---------------------------------------------------------------------------
word_2E8C6:     dc.w    $10, 8, $20, $40, 8, $10, 8, $10, 4, 8, $10, $40, 8, 8, 4, $20
                                        ; DATA XREF: Enemy_Stage10BeetleDelayTable+4   r

; Beetle falls with gravity and lands on terrain with alignment
Enemy_BeetleFallAndLand:                                ; DATA XREF: ROM:0002E818   o  ; was: sub_2E8E6
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2E92A
                cmpi.w  #$150,$14(a5)
                bgt.w   loc_2E416
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Collision_InitBufferPointers).l
                tst.w   d2
                beq.s   locret_2E92A
                moveq   #0,d0
                moveq   #0,d1
                jsr     (Physics_AlignToTerrain).l
                move.l  #$FFFE0000,$1C(a5)
                subq.w  #1,$4A(a5)
                bne.s   locret_2E92A
                addq.w  #2,4(a5)
locret_2E92A:                                           ; CODE XREF: Enemy_BeetleFallAndLand+E   j
                                        ; Enemy_BeetleFallAndLand+26   j
                rts
; End of function Enemy_BeetleFallAndLand
; Beetle falls with gravity checking if below screen threshold
Enemy_BeetleFallOffscreen:                              ; DATA XREF: ROM:0002E81A   o  ; was: sub_2E92C
                addi.l  #$2000,$1C(a5)
                btst    #7,$1C(a5)
                bne.s   locret_2E946
                cmpi.w  #$150,$14(a5)
                bgt.w   loc_2E416
locret_2E946:                                           ; CODE XREF: Enemy_BeetleFallOffscreen+E   j
                rts
; End of function Enemy_BeetleFallOffscreen
; Handles beetle enemy defeat
Enemy_Stage10BeetleDefeat:                              ; CODE XREF: Enemy_Stage10BeetleMain+A   j  ; was: sub_2E948
                                        ; Enemy_Stage10BeetleMain+12   j
                tst.w   $24(a5)
                bmi.s   loc_2E97A
                btst    #4,$22(a5)
                bne.s   loc_2E97A
                clr.l   $18(a5)
                clr.l   $1C(a5)
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
loc_2E97A:                                              ; CODE XREF: Enemy_Stage10BeetleDefeat+4   j
                                        ; Enemy_Stage10BeetleDefeat+C   j
                clr.w   4(a5)
                move.w  #$2D8,(a5)
                move.w  #$10,$48(a5)
                clr.w   $24(a5)
                clr.b   $21(a5)
                clr.b   $22(a5)
                move.l  #$FFFB8000,$1C(a5)
                rts
; End of function Enemy_Stage10BeetleDefeat
; Falling beetle with explosion
Enemy_Stage10BeetleFall:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2E99E
                addi.l  #$5C00,$1C(a5)
                subq.w  #1,$48(a5)
                bpl.s   loc_2E9BA
                jsr     (Projectile_ExplodeWithSound).l
                moveq   #$F,d0
                jmp     Boss_JetsripperAttackPattern1
; ---------------------------------------------------------------------------
loc_2E9BA:                                              ; CODE XREF: Enemy_Stage10BeetleFall+C   j
                bset    #7,2(a5)
                btst    #0,$49(a5)
                bne.s   locret_2E9CE
                bclr    #7,2(a5)
locret_2E9CE:                                           ; CODE XREF: Enemy_Stage10BeetleFall+28   j
                rts
; End of function Enemy_Stage10BeetleFall
; Checks beetle death conditions and spawns explosion effect
Enemy_BeetleDeathCheck:
                tst.w   $24(a5)                         ; was: sub_2E9D0
                bmi.s   locret_2E9FA
                btst    #4,$22(a5)
                bne.s   locret_2E9FA
                move.b  #$BC,d0
                jsr     (Sound_PlaySFX).l
                move.l  #off_E953C,8(a5)
                clr.w   $C(a5)
                jmp     Projectile_InitType88FromCurrent
; ---------------------------------------------------------------------------
locret_2E9FA:                                           ; CODE XREF: Enemy_BeetleDeathCheck+4   j
                                        ; Enemy_BeetleDeathCheck+C   j
                rts
; End of function Enemy_BeetleDeathCheck
; Flying enemy main handler
