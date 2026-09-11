Stage_Stage20Init:                                      ; DATA XREF: ROM:0000E4A8   o  ; was: sub_E7D8
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                move.w  #$50,(MessageSequenceState).w   ; 'P'
                bset    #1,(byte_FF80F8).w
                move.w  #$36,(word_FFA02A).w            ; '6'
                bsr.w   Gfx_Stage20InitPlanes
                move.w  #$6A0,(dword_FFA900).w
                move.w  (dword_FFA900).w,(word_FFA970).w
                move.w  (dword_FFA900).w,(word_FFA974).w
                move.w  (dword_FFA900).w,(word_FFA928).w
                movea.w #(word_FFDC40-M68K_RAM),a0
                move.w  #$428,(a0)
                move.w  #2,4(a0)
                move.b  #2,(VDPReg11Shadow+1).w
                move.b  #4,(byte_FFA95A).w
                move.b  #3,(byte_FFA95B).w
                rts
; End of function Stage_Stage20Init
; Stage 20 scroll handler
Stage_Stage20Scroll:                                    ; DATA XREF: ROM:0000E4AA   o  ; was: sub_E830
                tst.b   (byte_FFA958).w
                beq.s   loc_E83E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_E83E:                                               ; CODE XREF: Stage_Stage20Scroll+4   j
                bsr.w   Camera_UpdateTowardsPlayer
                bra.w   loc_EC06
; End of function Stage_Stage20Scroll
; Transition to Medusa form
Stage_MedusaTransition:                                 ; DATA XREF: ROM:0000E4AC   o  ; was: sub_E846
                tst.b   (byte_FFA958).w
                beq.s   loc_E854
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_E854:                                               ; CODE XREF: Stage_MedusaTransition+4   j
                bra.w   Stage_MedusaCamera
; End of function Stage_MedusaTransition
; Transition to Sylpheed form
Stage_SylpheedTransition:                               ; DATA XREF: ROM:0000E4AE   o  ; was: sub_E858
                subi.l  #$1400,(dword_FF9610).w
                bpl.s   loc_E86A
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF9610).w
loc_E86A:                                               ; CODE XREF: Stage_SylpheedTransition+8   j
                move.l  (dword_FF9610).w,d0
                sub.l   d0,(dword_FFA900).w
                bra.w   loc_EBBE
; End of function Stage_SylpheedTransition
; Camera control for Sylpheed
Stage_SylpheedCamera:                                   ; DATA XREF: ROM:0000E4B0   o  ; was: sub_E876
                tst.b   (byte_FFA958).w
                beq.s   locret_E890
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.l   (dword_FF9614).w
                clr.l   (dword_FF961C).w
                bsr.w   Gfx_SylpheedBackground
locret_E890:                                            ; CODE XREF: Stage_SylpheedCamera+4   j
                rts
; End of function Stage_SylpheedCamera
; Camera position update
Stage_SylpheedCameraUpdate:                             ; DATA XREF: ROM:0000E4B2   o  ; was: sub_E892
                bsr.w   Stage_SylpheedCameraLock
                bsr.w   Gfx_LoadSylpheedTiles
                tst.b   (byte_FFA958).w
                beq.s   locret_E8A8
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
locret_E8A8:                                            ; CODE XREF: Stage_SylpheedCameraUpdate+C   j
                rts
; End of function Stage_SylpheedCameraUpdate
; Graphics initialization
Stage_SylpheedGraphicsInit:                             ; DATA XREF: ROM:0000E4B4   o  ; was: sub_E8AA
                bsr.w   Gfx_LoadSylpheedTiles
                tst.b   (byte_FFA958).w
                beq.s   loc_E8BC
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_E8BC:                                               ; CODE XREF: Stage_SylpheedGraphicsInit+8   j
                                        ; Stage_SylpheedGraphicsUpdate+18   j
                bra.w   Gfx_SylpheedForeground
; End of function Stage_SylpheedGraphicsInit
; Graphics update handler
Stage_SylpheedGraphicsUpdate:                           ; DATA XREF: ROM:0000E4B6   o  ; was: sub_E8C0
                tst.b   (byte_FFA958).w
                beq.s   loc_E8D4
                addq.w  #2,(word_FFA950).w
                move.w  #$20,(dword_FFA960).w           ; ' '
                bra.w   Stage_ArtemisCameraUpdate
; ---------------------------------------------------------------------------
loc_E8D4:                                               ; CODE XREF: Stage_SylpheedGraphicsUpdate+4   j
                bsr.w   Gfx_LoadSylpheedPalette
                bra.w   loc_E8BC
; End of function Stage_SylpheedGraphicsUpdate
; Transition to Artemis form
Stage_ArtemisTransition:                                ; DATA XREF: ROM:0000E4B8   o  ; was: sub_E8DC
                bsr.w   Stage_ArtemisCameraLock
                bsr.w   Boss_ArtemisSpawnProjectile1
                subq.w  #1,(dword_FFA960).w
                bpl.s   locret_E8F8
                tst.w   (word_FFF720).w
                bmi.s   locret_E8F8
                addq.w  #2,(word_FFA950).w
                clr.l   (dword_FF8240).w
locret_E8F8:                                            ; CODE XREF: Stage_ArtemisTransition+C   j
                                        ; Stage_ArtemisTransition+12   j
                rts
; End of function Stage_ArtemisTransition
; Camera control for Artemis
Stage_ArtemisCamera:                                    ; DATA XREF: ROM:0000E4BA   o  ; was: sub_E8FA
                bsr.w   Stage_ArtemisGraphicsInit
                bpl.s   locret_E908
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
locret_E908:                                            ; CODE XREF: Stage_ArtemisCamera+4   j
                rts
; End of function Stage_ArtemisCamera
; Graphics update handler
Stage_ArtemisGraphicsUpdate:                            ; DATA XREF: ROM:0000E4BC   o  ; was: sub_E90A
                tst.b   (byte_FFA958).w
                beq.s   locret_E914
                addq.w  #2,(word_FFA950).w
locret_E914:                                            ; CODE XREF: Stage_ArtemisGraphicsUpdate+4   j
                rts
; End of function Stage_ArtemisGraphicsUpdate
; Background graphics setup
Gfx_ArtemisBackground:                                  ; DATA XREF: ROM:0000E4BE   o  ; was: sub_E916
                bsr.w   Gfx_ArtemisPlaneUpdate
                cmpi.w  #$E200,(dword_FFA904).w
                bne.s   locret_E92E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.w   (dword_FF8066).w
locret_E92E:                                            ; CODE XREF: Gfx_ArtemisBackground+A   j
                rts
; End of function Gfx_ArtemisBackground
; Foreground graphics setup
Gfx_ArtemisForeground:                                  ; DATA XREF: ROM:0000E4C0   o  ; was: sub_E930
                bsr.w   Gfx_ArtemisTileUpdate
                bsr.w   Camera_UpdateTowardsPlayer
                tst.b   (byte_FFA958).w
                beq.s   locret_E95A
                addq.w  #2,(word_FFA950).w
                move.w  #$40,(dword_FFA960).w           ; '@'
                clr.l   (dword_FF9614).w
                clr.l   (dword_FF961C).w
                move.b  #$F4,d0
                jsr     (Sound_PlaySFX).l
locret_E95A:                                            ; CODE XREF: Gfx_ArtemisForeground+C   j
                rts
; End of function Gfx_ArtemisForeground
; Handle Sirene boss intro with countdown and shake
Stage_SireneIntroSequence:                              ; DATA XREF: ROM:0000E4C2   o  ; was: sub_E95C
                move.w  #2,(word_FFA010).w
                subq.w  #1,(dword_FFA960).w
                bpl.s   loc_E99E
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                clr.l   (dword_FF9614).w
                move.b  #$F5,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$E400,(dword_FFA904).w
                move.w  #$E400,(word_FFA92C).w
loc_E98A:                                               ; CODE XREF: Stage_SireneUpdate1:loc_EA02   j
                                        ; sub_EA06:loc_EA20   j
                move.w  (RandomNumberState).w,d0
                andi.w  #3,d0
                addq.w  #4,d0
                move.w  d0,(word_FFA010).w
                move.w  #1,(word_FFA014).w
loc_E99E:                                               ; CODE XREF: Stage_SireneIntroSequence+A   j
                                        ; Boss_SireneSpawnProjectile1+14   j
                bra.w   Camera_UpdateTowardsPlayer
; End of function Stage_SireneIntroSequence
; Camera control for Sirene
Stage_SireneCamera:                                     ; CODE XREF: Stage_SireneUpdate1   p  ; was: sub_E9A2
                                        ; sub_EA06   p
                move.w  #$60,d0                         ; '`'
                cmp.w   (dword_FFA900).w,d0
                beq.s   loc_E9B8
                bpl.s   loc_E9B4
                subq.w  #1,(dword_FFA900).w
                bra.s   loc_E9B8
; ---------------------------------------------------------------------------
loc_E9B4:                                               ; CODE XREF: Stage_SireneCamera+A   j
                addq.w  #1,(dword_FFA900).w
loc_E9B8:                                               ; CODE XREF: Stage_SireneCamera+8   j
                                        ; Stage_SireneCamera+10   j
                addq.w  #1,(word_FFA970).w
                subq.w  #1,(word_FFA974).w
                cmp.w   (word_FFA970).w,d0
                bpl.s   locret_E9CE
                move.w  d0,(word_FFA970).w
                move.w  d0,(word_FFA974).w
locret_E9CE:                                            ; CODE XREF: Stage_SireneCamera+22   j
                rts
; End of function Stage_SireneCamera
; Updates Sirene stage camera/graphics and plays SFX
Stage_SireneUpdate1:                                    ; DATA XREF: ROM:0000E4C4   o  ; was: sub_E9D0
                bsr.s   Stage_SireneCamera
                bsr.w   Gfx_LoadSireneTiles
                bsr.w   Stage_SireneGraphicsInit
                tst.b   (byte_FFA958).w
                beq.s   loc_EA02
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                move.b  #$F6,d0
                jsr     (Sound_PlaySFX).l
                move.w  #$D0,(dword_FFA410).w
                move.w  #$188,(dword_FFA414).w
                addq.w  #2,(word_FFC624).w
loc_EA02:                                               ; CODE XREF: Stage_SireneUpdate1+E   j
                bra.w   loc_E98A
; End of function Stage_SireneUpdate1
; Updates Sirene stage with camera/tiles/palette loading
Stage_SireneUpdate2:                                    ; DATA XREF: ROM:0000E4C6   o  ; was: sub_EA06
                bsr.s   Stage_SireneCamera
                bsr.w   Gfx_LoadSireneTiles
                bsr.w   Gfx_LoadSirenePalette
                tst.b   (byte_FFA958).w
                beq.s   loc_EA20
                addq.w  #2,(word_FFA950).w
                move.w  #$40,(dword_FFA960).w           ; '@'
loc_EA20:                                               ; CODE XREF: Stage_SireneUpdate2+E   j
                bra.w   loc_E98A
; End of function Stage_SireneUpdate2
; Spawns projectile type 1
Boss_SireneSpawnProjectile1:                            ; DATA XREF: ROM:0000E4C8   o  ; was: sub_EA24
                subq.w  #1,(dword_FFA960).w
                bpl.s   loc_EA32
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
loc_EA32:                                               ; CODE XREF: Boss_SireneSpawnProjectile1+4   j
                move.w  #2,(word_FFA010).w
                bra.w   loc_E99E
; End of function Boss_SireneSpawnProjectile1
; Spawns projectile type 2
Boss_SireneSpawnProjectile2:                            ; DATA XREF: ROM:0000E4CA   o  ; was: sub_EA3C
                bsr.w   Camera_UpdateTowardsPlayer
                tst.b   (byte_FFA958).w
                beq.s   locret_EA74
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                move.w  #$40,(dword_FFA960+2).w         ; '@'
                clr.w   (dword_FFA908).w
                movea.l #$FFFF2020,a0
                move.w  #$A000,d0
                move.w  #0,d1
                moveq   #$7E,d7                         ; '~'
                jsr     (Gfx_UpdateTilemapIndices).l
                move.w  #$8000,(word_FF808A).w
locret_EA74:                                            ; CODE XREF: Boss_SireneSpawnProjectile2+8   j
                rts
; End of function Boss_SireneSpawnProjectile2
; Win cutscene initialization
