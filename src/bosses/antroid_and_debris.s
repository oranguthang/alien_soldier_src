Enemy_TinyWrapper:                                      ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F396
                moveq   #0,d0
                bra.s   loc_2F39E
; End of function Enemy_TinyWrapper
; Spawns multiple projectiles in spread pattern
Enemy_SpawnMultiShot:                                   ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F39A
                move.w  #1,d0
loc_2F39E:                                              ; CODE XREF: Enemy_TinyWrapper+2   j
                move.w  (word_FFA000).w,d1
                andi.w  #1,d1
                eor.w   d0,d1
                move.w  d1,$48(a5)
                move.w  4(a5),d0
                beq.s   Enemy_MultiShotDispatcher
                cmpi.w  #4,d0
                beq.s   Enemy_MultiShotDispatcher
                cmpi.w  #$70,$10(a5)                    ; 'p'
                bpl.s   loc_2F3C8
                move.w  #4,4(a5)
                bra.s   Enemy_MultiShotDispatcher
; ---------------------------------------------------------------------------
loc_2F3C8:                                              ; CODE XREF: Enemy_SpawnMultiShot+24   j
                nop
; State dispatcher for multi-shot enemy projectile handler
Enemy_MultiShotDispatcher:                              ; CODE XREF: Enemy_SpawnMultiShot+16   j  ; was: loc_2F3CA
                                        ; Enemy_SpawnMultiShot+1C   j
                move.w  4(a5),d0
                movea.w off_2F3DA(pc,d0.w),a0
                adda.l  #Enemy_TwinProjectileHandler,a0
                jmp     (a0)
; End of function Enemy_SpawnMultiShot
; ---------------------------------------------------------------------------
off_2F3DA:      dc.w    Enemy_TwinProjectileHandler-Enemy_TwinProjectileHandler
                                        ; DATA XREF: Enemy_SpawnMultiShot+34   r
                dc.w    Enemy_DestroyOnContact-Enemy_TwinProjectileHandler
                dc.w    Boss_AntroidUpdateTiles-Enemy_TwinProjectileHandler
                dc.w    Boss_AntroidPhaseCounter-Enemy_TwinProjectileHandler
                dc.w    Boss_CheckPhaseTrigger-Enemy_TwinProjectileHandler
                dc.w    Boss_AdvanceToNextPhase-Enemy_TwinProjectileHandler

; Handles paired projectile spawn with symmetric angles
Enemy_TwinProjectileHandler:                            ; DATA XREF: Enemy_SpawnMultiShot+38   o  ; was: sub_2F3E6
                                        ; ROM:off_2F3DA   o
                addq.w  #2,4(a5)
                move.w  #$100,2(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                move.w  #5,$4E(a5)
                move.w  $5E(a5),d0
                move.w  word_2F41A(pc,d0.w),$50(a5)
                move.w  #$4000,$52(a5)
                move.b  #0,$54(a5)
                move.b  #1,$55(a5)
locret_2F418:                                           ; CODE XREF: Boss_AntroidUpdateTiles+18   j
                                        ; Boss_UpdateTilesDMA+4   j
                rts
; End of function Enemy_TwinProjectileHandler
; ---------------------------------------------------------------------------
word_2F41A:     dc.w    $42E4, $4290, $42B4, $42E0, $4284, $42B0, $42D4, $4280
                                        ; DATA XREF: Enemy_TwinProjectileHandler+1A   r

; Checks collision flags and destroys on player contact
Enemy_DestroyOnContact:                                 ; DATA XREF: ROM:0002F3DC   o  ; was: sub_2F42A
                cmpi.w  #$1A8,$10(a5)
                bpl.s   locret_2F46A
                subq.w  #1,$4A(a5)
                bpl.s   locret_2F46A
                move.w  #6,4(a5)
                jsr     (Sprite_FindFreeEnemySlot).l
                bne.s   locret_2F46A
                move.w  #$2B0,(a0)
                move.b  #$B,$5F(a0)
                move.w  $10(a5),$10(a0)
                move.w  $14(a5),$14(a0)
                addq.w  #8,$14(a0)
                move.b  #$45,d0                         ; 'E'
                jsr     (Sound_PlaySFX).l
locret_2F46A:                                           ; CODE XREF: Enemy_DestroyOnContact+6   j
                                        ; Enemy_DestroyOnContact+C   j
                rts
; End of function Enemy_DestroyOnContact
; Increments phase counter until reaching 8 then advances state
Boss_AntroidPhaseCounter:                               ; DATA XREF: ROM:0002F3E0   o  ; was: sub_2F46C
                tst.w   $48(a5)
                bne.s   locret_2F498
                addq.w  #2,$4C(a5)
                cmpi.w  #8,$4C(a5)
                bne.w   Boss_AntroidDMATileTransfer
                addq.w  #2,4(a5)
                move.w  #$20,$4A(a5)                    ; ' '
                bra.w   Boss_AntroidDMATileTransfer
; End of function Boss_AntroidPhaseCounter
; Checks if boss phase trigger condition met
Boss_CheckPhaseTrigger:                                 ; DATA XREF: ROM:0002F3E2   o  ; was: sub_2F48E
                subq.w  #1,$4A(a5)
                bpl.s   locret_2F498
                addq.w  #2,4(a5)
locret_2F498:                                           ; CODE XREF: Boss_AntroidPhaseCounter+4   j
                                        ; Boss_CheckPhaseTrigger+4   j
                rts
; End of function Boss_CheckPhaseTrigger
; Advances boss to next phase state
Boss_AdvanceToNextPhase:                                ; DATA XREF: ROM:0002F3E4   o  ; was: sub_2F49A
                tst.w   $48(a5)
                bne.s   locret_2F498
                subq.w  #2,$4C(a5)
                bne.w   Boss_AntroidDMATileTransfer
                subq.w  #1,$4E(a5)
                bmi.s   loc_2F4CE
                move.w  #2,4(a5)
                move.w  (dword_FFFF08).w,d0
                andi.w  #$7F,d0
                addi.w  #$40,d0                         ; '@'
                move.w  d0,$4A(a5)
                bra.w   Boss_AntroidDMATileTransfer
; End of function Boss_AdvanceToNextPhase
; Updates boss tiles via DMA transfer based on state
Boss_AntroidUpdateTiles:                                ; DATA XREF: ROM:0002F3DE   o  ; was: sub_2F4C8
                tst.w   $48(a5)
                bne.s   locret_2F498
loc_2F4CE:                                              ; CODE XREF: Boss_AdvanceToNextPhase+12   j
                bset    #4,2(a5)
                clr.w   $4C(a5)
                bra.w   *+4
; ---------------------------------------------------------------------------
loc_2F4DC:                                              ; CODE XREF: Boss_AntroidUpdateTiles+10   j
                                        ; Boss_EnableVisibilityFlag+10   j
                tst.w   $48(a5)
                bne.w   locret_2F418
; Transfers Antroid boss tiles via DMA using lookup table
Boss_AntroidDMATileTransfer:                            ; CODE XREF: Boss_AntroidPhaseCounter+10   j  ; was: loc_2F4E4
                                        ; Boss_AntroidPhaseCounter+1E   j
                move.w  $4C(a5),d0
                move.w  word_2F4FA(pc,d0.w),$56(a5)
                movea.w a5,a0
                adda.w  #$50,a0                         ; 'P'
                jmp     Gfx_DMATransferTiles
; End of function Boss_AntroidUpdateTiles
; ---------------------------------------------------------------------------
word_2F4FA:     dc.w    $878C, $888D, $898E, $8A8F, $8B90
                                        ; DATA XREF: Boss_AntroidUpdateTiles+20   r

; Initializes 6 debris entities in loop
Enemy_InitStage10Debris:                                ; CODE XREF: Stage_LoadStage10Graphics+A   p  ; was: sub_2F504
                movea.w #(byte_FFD8E0-M68K_RAM),a0
                moveq   #5,d7
loc_2F50A:                                              ; CODE XREF: Enemy_InitStage10Debris+C   j
                bsr.s   Enemy_InitDebrisEntity
                lea     $60(a0),a0
                dbf     d7,loc_2F50A
                rts
; End of function Enemy_InitStage10Debris
; Initializes single debris entity with position
Enemy_InitDebrisEntity:                                 ; CODE XREF: Enemy_InitStage10Debris:loc_2F50A   p  ; was: sub_2F516
                move.w  #$208,(a0)
                move.w  #$8C80,2(a0)
                move.w  #0,8(a0)
                move.w  #$FCFC,$A(a0)
                move.b  #$7C,$20(a0)                    ; '|'
                move.w  (dword_FFA900).w,$48(a0)
                move.w  #$44F5,$E(a0)
; Sets random velocity and position for debris entities
Enemy_DebrisSetRandomVelocity:                          ; CODE XREF: Enemy_DebrisUpdate+8   j  ; was: loc_2F53E
                                        ; Enemy_DebrisUpdate+12   j
                moveq   #0,d0
                move.w  (dword_FFFF08+2).w,d0
                andi.w  #$7FFF,d0
                addi.w  #-$8000,d0
                move.l  d0,$1C(a0)
                move.b  (dword_FFFF08).w,d0
                andi.w  #$FF,d0
                addi.w  #$A0,d0
                move.w  (dword_FFA900).w,d1
                sub.w   $48(a0),d1
                add.w   d1,d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                andi.w  #$7F,d0
                addi.w  #$80,d0
                move.w  d0,$14(a0)
                jmp     (RandomNumber).l
; End of function Enemy_InitDebrisEntity
; Updates debris position with screen bounds
Enemy_DebrisUpdate:                                     ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2F580
                movea.w a5,a0
                cmpi.w  #$80,$10(a5)
                bmi.w   Enemy_DebrisSetRandomVelocity
                cmpi.w  #$1C0,$10(a5)
                bpl.w   Enemy_DebrisSetRandomVelocity
                cmpi.w  #$138,$14(a5)
                bpl.w   Enemy_DebrisSetRandomVelocity
                move.w  (dword_FFA900).w,d0
                sub.w   $48(a5),d0
                asr.w   #1,d0
                sub.w   d0,$10(a5)
                move.w  (dword_FFA900).w,$48(a5)
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                move.l  d0,$18(a5)
                rts
; End of function Enemy_DebrisUpdate
; Main handler for ship platform
