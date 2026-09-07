Stage_InitProjectileSpawn:                              ; CODE XREF: Stage_InitStage7+6   p  ; was: sub_D5BC
                move.w  #$CC,(dword_FF8062+2).w
                clr.w   (dword_FF8066).w
                rts
; End of function Stage_InitProjectileSpawn
; Spawns intro projectiles with timing and position
Stage_SpawnIntroProjectile:                             ; CODE XREF: Stage_Stage7ScrollUpdate+3E   j  ; was: sub_D5C8
                                        ; sub_CD0A   p
                btst    #0,(word_FFA000+1).w
                bne.s   locret_D622
                movea.w #(byte_FFD700-M68K_RAM),a0
                jsr     (Projectile_FindFreePrimarySlot_CheckEnemyRange).l
                bne.s   locret_D622
                move.w  #$178,(a0)
                move.w  #$8100,2(a0)
                move.w  #$2240,$E(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.w  #8,$48(a0)
                move.b  #$60,$20(a0)                    ; '`'
                clr.w   $10(a0)
                move.w  (dword_FF8062+2).w,$14(a0)
                addi.w  #$11,(dword_FF8062+2).w
                cmpi.w  #$13C,(dword_FF8062+2).w
                bmi.s   locret_D622
                move.w  #$CC,(dword_FF8062+2).w
locret_D622:                                            ; CODE XREF: Stage_SpawnIntroProjectile+6   j
                                        ; Stage_SpawnIntroProjectile+12   j
                rts
; End of function Stage_SpawnIntroProjectile
; Intro falling projectile with screen position and flicker
Projectile_IntroFalling:                                ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_D624
                subq.w  #1,$48(a5)
                bpl.s   loc_D632
                bset    #4,2(a5)
                rts
; ---------------------------------------------------------------------------
loc_D632:                                               ; CODE XREF: Projectile_IntroFalling+4   j
                move.w  #$1114,d0
                sub.w   (dword_FFA900).w,d0
                move.w  d0,$10(a5)
                bset    #7,2(a5)
                btst    #0,(word_FFA000+1).w
                bne.s   locret_D652
                bclr    #7,2(a5)
locret_D652:                                            ; CODE XREF: Projectile_IntroFalling+26   j
                rts
; End of function Projectile_IntroFalling
; Loads Terobuster boss tile graphics progressively
Stage_LoadTerobusterTiles:                              ; CODE XREF: Stage_InitTerobusterBoss+C   p  ; was: sub_D654
                                        ; Stage_PostTerobusterIntro+4   p
                move.w  (dword_FF8066).w,d0
                cmpi.w  #$14,d0
                bmi.s   loc_D67A
                lea     byte_D6C6(pc),a0
                nop
                btst    #3,(word_FFA000+1).w
                bne.s   loc_D672
                lea     byte_D6CE(pc),a0
                nop
loc_D672:                                               ; CODE XREF: Stage_LoadTerobusterTiles+16   j
                jmp     Gfx_LoadCompressedTiles
; ---------------------------------------------------------------------------
locret_D678:                                            ; CODE XREF: Stage_LoadTerobusterTiles+2E   j
                rts
; ---------------------------------------------------------------------------
loc_D67A:                                               ; CODE XREF: Stage_LoadTerobusterTiles+8   j
                move.w  (word_FFA000).w,d1
                andi.w  #7,d1
                bne.s   locret_D678
                movea.l off_D692(pc,d0.w),a0
                addq.w  #4,(dword_FF8066).w
                jmp     Gfx_LoadCompressedTiles
; End of function Stage_LoadTerobusterTiles
; ---------------------------------------------------------------------------
off_D692:       dc.l    byte_D6A6
                dc.l    byte_D6AE
                dc.l    byte_D6B6
                dc.l    byte_D6BE
                dc.l    byte_D6C6
byte_D6A6:      dc.b    $44, $B4, $40, 0, 1, 0, $F0, $F1
                                        ; DATA XREF: Stage_PostTerobusterTransition+16   o
                                        ; ROM:off_D692   o
byte_D6AE:      dc.b    $44, $B4, $40, 0, 1, 0, $F2, $F3
                                        ; DATA XREF: ROM:0000D696   o
byte_D6B6:      dc.b    $44, $B4, $40, 0, 1, 0, $F4, $F5
                                        ; DATA XREF: ROM:0000D69A   o
byte_D6BE:      dc.b    $44, $B4, $40, 0, 1, 0, $F6, $F7
                                        ; DATA XREF: ROM:0000D69E   o
byte_D6C6:      dc.b    $44, $B4, $40, 0, 1, 0, $F8, $F9
                                        ; DATA XREF: Stage_LoadTerobusterTiles+A   o
                                        ; ROM:0000D6A2   o
byte_D6CE:      dc.b    $44, $B4, $40, 0, 1, 0, $FA, $FB
                                        ; DATA XREF: Stage_LoadTerobusterTiles+18   o

; Initializes Flying-Neo entity with sprite and position
Stage_InitFlyingNeoEntity:                              ; CODE XREF: Stage_InitStage8Train+3A   p  ; was: sub_D6D6
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$170,(a0)
                move.w  #$D00,2(a0)
                clr.w   4(a0)
                move.l  #off_19C720,8(a0)
                clr.w   $C(a0)
                move.w  #$81E8,$E(a0)
                clr.b   $20(a0)
                move.w  #$910,$10(a0)
                move.w  #$110,$14(a0)
                clr.l   $18(a0)
                clr.l   $1C(a0)
                rts
; End of function Stage_InitFlyingNeoEntity
; Spawns Flying-Neo boss with DMA tile transfer
