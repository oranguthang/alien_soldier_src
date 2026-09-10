Stage_FlyingNeoSpawn:                                   ; CODE XREF: Stage_FlyingNeoScrollUpdate+14   p  ; was: sub_D714
                movea.w #(word_FFDC40-M68K_RAM),a0
                addq.w  #2,4(a0)
                move.w  #$EF00,2(a0)
                move.l  #$FFFAE000,$18(a0)
                move.l  #$FFFE8000,$1C(a0)
                lea     byte_D74E(pc),a0
                nop
                jmp     Gfx_DMATransferTiles
; End of function Stage_FlyingNeoSpawn
; Applies gravity acceleration to Flying-Neo entity
Entity_FlyingNeoGravityAccel:                           ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_D73E
                tst.w   4(a5)
                beq.s   locret_D74C
                addi.l  #$2000,$1C(a5)
locret_D74C:                                            ; CODE XREF: Entity_FlyingNeoGravityAccel+4   j
                rts
; End of function Entity_FlyingNeoGravityAccel
; ---------------------------------------------------------------------------
byte_D74E:      dc.b    $66, $68, $40, 0, 1, 2, $1C, $1D, $21, $22, $26, $27
                                        ; DATA XREF: Stage_FlyingNeoSpawn+1E   o

; Initializes Flying-Neo boss entity for battle
Stage_FlyingNeoInitBoss:                                ; CODE XREF: Stage_FlyingNeoBattleStart+1E   p  ; was: sub_D75A
                                        ; Stage_InitStage9Flies+24   p
                lea     (FlyingNeoAndMidgamePaletteCommandBank).l,a0
                jmp     Gfx_LoadPaletteCommand
; End of function Stage_FlyingNeoInitBoss
; Spawns random lightning effects with position variation
Effect_SpawnRandomLightning:                            ; CODE XREF: Stage_TrainScrollPhysics+8   p  ; was: sub_D766
                                        ; Stage_FlyingNeoVerticalScroll+3A   p
                move.w  (word_FF821E).w,d7
                bmi.w   locret_D838
                tst.w   (word_FF8220).w
                bne.w   locret_D838
                tst.w   (word_FF8222).w
                bne.w   locret_D838
                addq.w  #1,(dword_FF8062).w
                cmpi.w  #$42,(dword_FF8062).w           ; 'B'
                bne.w   locret_D838
                move.w  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                addq.w  #1,d0
                move.w  d0,(dword_FF8062).w
                move.w  (dword_FFFF08).w,d0
                andi.w  #3,d0
                beq.s   loc_D7BA
                move.b  (dword_FFFF08).w,d0
                andi.w  #7,d0
                addq.w  #3,d0
                move.w  d0,(word_FF8218).w
                move.w  #8,(word_FF8220).w
                rts
; ---------------------------------------------------------------------------
loc_D7BA:                                               ; CODE XREF: Effect_SpawnRandomLightning+3C   j
                move.w  #2,(word_FF8222).w
                move.b  (dword_FFFF08).w,d0
                andi.w  #6,d0
                addq.w  #8,d0
                move.w  d0,(word_FF8218).w
                cmpi.w  #2,d7
                beq.s   Effect_CreateLightningSprite
                move.b  #$1A,d0
                jsr     (Sound_PlaySFX).l
; Creates lightning sprite with randomized position for stage 8 effects
Effect_CreateLightningSprite:                           ; CODE XREF: Effect_SpawnRandomLightning+6C   j  ; was: loc_D7DE
                cmpi.w  #1,d7
                beq.s   locret_D838
                movea.w #(word_FFDB20-M68K_RAM),a0
                move.w  #$160,(a0)
                move.w  #$E100,2(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$C,d0
                move.l  off_D83A(pc,d0.w),8(a0)
                clr.w   $C(a0)
                move.w  #$1E8,$E(a0)
                move.b  #$70,$20(a0)                    ; 'p'
                move.w  (dword_FFFF08).w,d0
                andi.w  #$800,d0
                or.w    d0,$E(a0)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  d0,$10(a0)
                move.w  #$F8,d0
                add.w   (dword_FFA904).w,d0
                move.w  d0,$14(a0)
locret_D838:                                            ; CODE XREF: Effect_SpawnRandomLightning+4   j
                                        ; Effect_SpawnRandomLightning+C   j
                rts
; End of function Effect_SpawnRandomLightning
; ---------------------------------------------------------------------------
off_D83A:       dc.l    off_19C6A0
                dc.l    off_19C6BC
                dc.l    off_19C6F0
                dc.l    off_19C708
word_D84A:      dc.w    0, $E308, 9, $E326, $E328, $E32A, $E32C, $E32E
                                        ; DATA XREF: Stage_TrainScrollPhysics   o
                dc.w    $E330, $E332, $E334, $E336, $E324
word_D864:      dc.w    1, $E308, $E36E, $22, $E324, $E326, $E328, $E32A
                                        ; DATA XREF: Stage_FlyingNeoVerticalScroll+32   o
                                        ; sub_D01E:loc_D040   o
                dc.w    $E32C, $E32E, $E330, $E332, $E344, $E346, $E348, $E34A
                dc.w    $E34C, $E34E, $E350, $E352, $E354, $E356, $E358, $E35A
                dc.w    $E35C, $E35E, $E362, $E364, $E366, $E368, $E36A, $E370
                dc.w    $E372, $E374, $E376, $E378, $E37A, $E37C, $E37E
word_D8B2:      dc.w    7, $E308, $E30A, $E30C, $E30E, $E310, $E312, $E314
                                        ; DATA XREF: Stage_FliesScrollUpdate   o
                                        ; sub_D1EA   o
                dc.w    $E316, $23, $E324, $E326, $E328, $E32A, $E32C, $E32E
                dc.w    $E330, $E332, $E344, $E346, $E348, $E34A, $E34C, $E34E
                dc.w    $E350, $E352, $E354, $E356, $E358, $E35A, $E35C, $E35E
                dc.w    $E362, $E364, $E366, $E368, $E36A, $E36E, $E370, $E372
                dc.w    $E374, $E376, $E378, $E37A, $E37C, $E37E

; Initializes Stage 10 with scroll and enemies
