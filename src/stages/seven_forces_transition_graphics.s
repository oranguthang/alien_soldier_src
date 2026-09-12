; Seven Forces victory cutscene states and transition rendering helpers
Cutscene_SevenForcesVictoryState0:                      ; DATA XREF: ROM:0000E4CC   o  ; was: sub_EA76
                bsr.w   Cutscene_SevenForcesCamera2
                bsr.w   Cutscene_SevenForcesCamera1
                tst.b   (byte_FFA958).w
                beq.s   Cutscene_SevenForcesUpdateClosingOffsets
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
Cutscene_SevenForcesUpdateClosingOffsets:               ; CODE XREF: Cutscene_SevenForcesVictoryState0+C   j  ; was: loc_EA8C
                                        ; Cutscene_SevenForcesVictoryState1:Cutscene_SevenForcesVictoryState1Update   j
                tst.w   (dword_FFA960+2).w
                beq.s   Cutscene_SevenForcesUpdateCamera
                subq.w  #8,(dword_FFA960+2).w
                addq.w  #8,(word_FFA970).w
                subq.w  #8,(word_FFA974).w
Cutscene_SevenForcesUpdateCamera:                       ; CODE XREF: Cutscene_SevenForcesVictoryState0+1A   j  ; was: loc_EA9E
                bsr.w   Camera_UpdateHorizontalTowardsPlayer
                rts
; End of function Cutscene_SevenForcesVictoryState0
; Cutscene state handler 1
Cutscene_SevenForcesVictoryState1:                      ; DATA XREF: ROM:0000E4CE   o  ; was: sub_EAA4
                bsr.w   Cutscene_SevenForcesCamera2
                tst.b   (byte_FFA958).w
                beq.s   Cutscene_SevenForcesVictoryState1Update
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
Cutscene_SevenForcesVictoryState1Update:                ; CODE XREF: Cutscene_SevenForcesVictoryState1+8   j  ; was: loc_EAB6
                bra.w   Cutscene_SevenForcesUpdateClosingOffsets
; End of function Cutscene_SevenForcesVictoryState1
; Cutscene state handler 2
Cutscene_SevenForcesVictoryState2:                      ; DATA XREF: ROM:0000E4D0   o  ; was: sub_EABA
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   Cutscene_SevenForcesUpdateClosingOffsets
                tst.b   (byte_FFA958).w
                beq.s   Cutscene_SevenForcesVictoryState2Return
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
                bsr.w   Cutscene_SevenForcesLoadGraphics
Cutscene_SevenForcesVictoryState2Return:                ; CODE XREF: Cutscene_SevenForcesVictoryState2+10   j  ; was: locret_EAD8
                rts
; End of function Cutscene_SevenForcesVictoryState2
; Cutscene state handler 3
Cutscene_SevenForcesVictoryState3:                      ; DATA XREF: ROM:0000E4D2   o  ; was: sub_EADA
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   Cutscene_SevenForcesUpdateClosingOffsets
                bsr.w   Gfx_InitializeSevenForcesCutsceneTilemap
                bmi.s   Cutscene_SevenForcesVictoryState3Return
                addq.w  #2,(word_FFA950).w
Cutscene_SevenForcesVictoryState3Return:                ; CODE XREF: Cutscene_SevenForcesVictoryState3+10   j  ; was: locret_EAF0
                rts
; End of function Cutscene_SevenForcesVictoryState3
; Cutscene state handler 4
Cutscene_SevenForcesVictoryState4:                      ; DATA XREF: ROM:0000E4D4   o  ; was: sub_EAF2
                addi.l  #$78000,(dword_FFA90C).w
                bsr.w   Cutscene_SevenForcesUpdateClosingOffsets
                bsr.w   Gfx_CheckSevenForcesCutsceneBackgroundComplete
                bpl.s   Cutscene_SevenForcesVictoryState4Return
                addq.w  #2,(word_FFA950).w
                clr.w   (dword_FFA900).w
                clr.w   (word_FFA928).w
                clr.w   (dword_FFA904).w
                clr.w   (word_FFA92C).w
Cutscene_SevenForcesVictoryState4Return:                ; CODE XREF: Cutscene_SevenForcesVictoryState4+10   j  ; was: locret_EB18
                rts
; End of function Cutscene_SevenForcesVictoryState4
; Cutscene state handler 5
Cutscene_SevenForcesVictoryState5:                      ; DATA XREF: ROM:0000E4D6   o  ; was: sub_EB1A
                andi.w  #$1FF,(dword_FFA90C).w
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$200,(dword_FFA90C).w
                bmi.s   Cutscene_SevenForcesVictoryState5Idle
                andi.w  #$1FF,(dword_FFA90C).w
                addi.w  #-$1C00,(dword_FFA90C).w
                addq.w  #2,(word_FFA950).w
                clr.b   (byte_FFA958).w
Cutscene_SevenForcesVictoryState5Idle:                  ; CODE XREF: Cutscene_SevenForcesVictoryState5+14   j  ; was: loc_EB44
                bra.w   Cutscene_SevenForcesVictoryIdleState
; End of function Cutscene_SevenForcesVictoryState5
; Cutscene state handler 6
Cutscene_SevenForcesVictoryState6:                      ; DATA XREF: ROM:0000E4D8   o  ; was: sub_EB48
                bsr.w   Cutscene_SevenForcesVictoryIdleState
                bsr.w   Cutscene_SevenForcesCamera3
                tst.b   (byte_FFA958).w
                beq.s   Cutscene_SevenForcesVictoryState6Return
                addq.w  #2,(word_FFA950).w
Cutscene_SevenForcesVictoryState6Return:                ; CODE XREF: Cutscene_SevenForcesVictoryState6+C   j  ; was: locret_EB5A
                rts
; End of function Cutscene_SevenForcesVictoryState6
; Empty cutscene state for Seven Forces sequence
Cutscene_SevenForcesVictoryIdleState:                   ; CODE XREF: Cutscene_SevenForcesVictoryState5:Cutscene_SevenForcesVictoryState5Idle   j  ; was: nullsub_27
                                        ; Cutscene_SevenForcesVictoryState6   p
                                        ; DATA XREF:
                rts
; End of function Cutscene_SevenForcesVictoryIdleState
; Updates camera position and calculates scroll
UnreferencedSevenForcesCameraScrollUpdate:
                bsr.w   Camera_UpdateHorizontalTowardsPlayer  ; was: sub_EB5E
                bsr.w   Scroll_UpdateQuarterHorizontalPosition
                move.w  (dword_FFA908).w,d0
                addi.w  #$40,d0                         ; '@'
                neg.w   d0
                move.w  d0,(HScrollBuffer).w
                move.w  (dword_FFA900).w,(dword_FFA908).w
                rts
; End of function UnreferencedSevenForcesCameraScrollUpdate
; Checks boss defeat and triggers stage transition
UnreferencedSevenForcesBossTransitionCheck:
                tst.w   (word_FF8230).w                 ; was: sub_EB7C
                bne.w   Stage_Stage18EmptyHandler
                tst.w   (word_FF8138).w
                bne.w   Stage_Stage18EmptyHandler
                move.b  #$93,(byte_FFA230).w
                move.l  #byte_1E4E5,(dword_FFA22C).w
                bra.w   Stage_StartWeaponSelectTransition
; End of function UnreferencedSevenForcesBossTransitionCheck
; Camera control for Medusa
Stage_SevenForcesUpdateMedusaCameraAndParallax:         ; CODE XREF: Stage_SevenForcesAdvanceToMedusa:Stage_SevenForcesUpdateMedusaCamera   j  ; was: sub_EB9E
                addi.l  #$200,(dword_FF9610).w
                cmpi.w  #2,(dword_FF9610).w
                bmi.s   Stage_SevenForcesStoreMedusaCameraVelocity
                move.l  #$20000,(dword_FF9610).w
Stage_SevenForcesStoreMedusaCameraVelocity:             ; CODE XREF: Stage_SevenForcesUpdateMedusaCameraAndParallax+E   j  ; was: loc_EBB6
                move.l  (dword_FF9610).w,d0
                sub.l   d0,(dword_FFA900).w
Stage_SevenForcesWrapVerticalCamera:                    ; CODE XREF: Stage_SevenForcesFinishMedusaScroll+1A   j  ; was: loc_EBBE
                bpl.s   Stage_SevenForcesPrepareMedusaPrimaryPlaneOrigin
                addi.w  #$800,(dword_FFA900).w
                addi.w  #$800,(word_FFA928).w
                move.w  #1,(word_FF9804).w
Stage_SevenForcesPrepareMedusaPrimaryPlaneOrigin:       ; CODE XREF: Stage_SevenForcesWrapVerticalCamera   j  ; was: loc_EBD2
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                bpl.s   Stage_SevenForcesRenderMedusaPrimaryPlane
                addi.w  #$800,d0
Stage_SevenForcesRenderMedusaPrimaryPlane:              ; CODE XREF: Stage_SevenForcesUpdateMedusaCameraAndParallax+3C   j  ; was: loc_EBE0
                move.w  (dword_FFA904).w,d1
                jsr     (Tilemap_QueuePrimaryPlaneColumn).l
                move.w  (dword_FFA900).w,d0
                subi.w  #$10,d0
                bpl.s   Stage_SevenForcesRenderMedusaSecondaryPlane
                addi.w  #$800,d0
Stage_SevenForcesRenderMedusaSecondaryPlane:            ; CODE XREF: Stage_SevenForcesUpdateMedusaCameraAndParallax+54   j  ; was: loc_EBF8
                move.w  (dword_FFA904).w,d1
                subi.w  #$C00,d1
                jsr     (Tilemap_PopulateUnqueuedColumnFromDescriptor).l
Gfx_UpdateSevenForcesParallaxRows:                      ; CODE XREF: Stage_SevenForcesUpdateStage20Scroll+12   j  ; was: loc_EC06
                move.w  (dword_FFA900).w,d0
                neg.w   d0
                asr.w   #1,d0
                move.w  d0,d1
                asr.w   #1,d1
                movea.w #(byte_FFE482-M68K_RAM),a0
                moveq   #$20,d6                         ; ' '
                moveq   #6,d7
Gfx_WriteSevenForcesPrimaryParallaxRowsA:               ; CODE XREF: Stage_SevenForcesUpdateMedusaCameraAndParallax+80   j  ; was: loc_EC1A
                move.w  d0,(a0)
                adda.w  d6,a0
                dbf     d7,Gfx_WriteSevenForcesPrimaryParallaxRowsA
                moveq   #7,d7
Gfx_WriteSevenForcesSecondaryParallaxRows:              ; CODE XREF: Stage_SevenForcesUpdateMedusaCameraAndParallax+8A   j  ; was: loc_EC24
                move.w  d1,(a0)
                adda.w  d6,a0
                dbf     d7,Gfx_WriteSevenForcesSecondaryParallaxRows
                moveq   #8,d7
Gfx_WriteSevenForcesPrimaryParallaxRowsB:               ; CODE XREF: Stage_SevenForcesUpdateMedusaCameraAndParallax+94   j  ; was: loc_EC2E
                move.w  d0,(a0)
                adda.w  d6,a0
                dbf     d7,Gfx_WriteSevenForcesPrimaryParallaxRowsB
                rts
; End of function Stage_SevenForcesUpdateMedusaCameraAndParallax
; Camera lock handler
Stage_SevenForcesUpdateSylpheedPrimaryPlane:            ; CODE XREF: Stage_SevenForcesUpdateSylpheedScroll   p  ; was: sub_EC38
                move.l  (dword_FF9614).w,d0
                subi.l  #$2000,d0
                cmpi.l  #$FFF88000,d0
                bpl.s   Stage_SevenForcesStoreSylpheedPrimaryVelocity
                move.l  #$FFF88000,d0
Stage_SevenForcesStoreSylpheedPrimaryVelocity:          ; CODE XREF: Stage_SevenForcesUpdateSylpheedPrimaryPlane+10   j  ; was: loc_EC50
                move.l  d0,(dword_FF9614).w
                add.l   d0,(dword_FFA904).w
                cmpi.w  #$F600,(dword_FFA904).w
                bpl.s   Stage_SevenForcesPrepareSylpheedPrimaryOrigin
                move.b  #1,(byte_FFA958).w
Stage_SevenForcesPrepareSylpheedPrimaryOrigin:          ; CODE XREF: Stage_SevenForcesUpdateSylpheedPrimaryPlane+26   j  ; was: loc_EC66
                move.w  (dword_FFA900).w,d0
                subi.w  #$60,d0                         ; '`'
                bpl.s   Stage_SevenForcesRenderSylpheedPrimaryPlane
                addi.w  #$800,d0
Stage_SevenForcesRenderSylpheedPrimaryPlane:            ; CODE XREF: Stage_SevenForcesUpdateSylpheedPrimaryPlane+36   j  ; was: loc_EC74
                move.w  (dword_FFA904).w,d1
                subi.w  #$F8,d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Stage_SevenForcesUpdateSylpheedPrimaryPlane
; Loads Sylpheed tiles
Stage_SevenForcesUpdateSylpheedSecondaryPlane:          ; CODE XREF: Stage_SevenForcesUpdateSylpheedScroll+4   p  ; was: sub_EC86
                                        ; sub_E8AA   p
                bsr.s   Stage_SevenForcesAdvanceSylpheedSecondaryScroll
                cmpi.w  #$F400,(dword_FFA90C).w
                bpl.s   Stage_SevenForcesRenderSylpheedSecondaryPlane
                move.b  #1,(byte_FFA958).w
Stage_SevenForcesRenderSylpheedSecondaryPlane:          ; CODE XREF: Stage_SevenForcesUpdateSylpheedSecondaryPlane+8   j  ; was: loc_EC96
                moveq   #0,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$F8,d1
                lea     (Gfx_FrontendAlternateVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Stage_SevenForcesUpdateSylpheedSecondaryPlane
; Loads Sylpheed palette
Stage_SevenForcesAdvanceSylpheedSecondaryScroll:        ; CODE XREF: Stage_SevenForcesFinishSylpheedForeground:Stage_SevenForcesContinueSylpheedForeground   p  ; was: sub_ECAA
                                        ; sub_EC86   p
                move.l  (dword_FF961C).w,d0
                subi.l  #$1000,d0
                cmpi.l  #$FFF88000,d0
                bpl.s   Stage_SevenForcesApplySylpheedSecondaryVelocity
                move.l  #$FFF88000,d0
Stage_SevenForcesApplySylpheedSecondaryVelocity:        ; CODE XREF: Stage_SevenForcesAdvanceSylpheedSecondaryScroll+10   j  ; was: loc_ECC2
                move.l  d0,(dword_FF961C).w
                add.l   d0,(dword_FFA90C).w
                rts
; End of function Stage_SevenForcesAdvanceSylpheedSecondaryScroll
; Advances and renders the Artemis background plane
Stage_SevenForcesUpdateArtemisBackgroundPlane:          ; CODE XREF: Stage_SevenForcesScrollArtemisBackground   p  ; was: sub_ECCC
                subi.w  #6,(dword_FFA904).w
                cmpi.w  #$E200,(dword_FFA904).w
                bpl.s   Stage_SevenForcesRenderArtemisBackgroundPlane
                move.w  #$E200,(dword_FFA904).w
Stage_SevenForcesRenderArtemisBackgroundPlane:          ; CODE XREF: Stage_SevenForcesUpdateArtemisBackgroundPlane+C   j  ; was: loc_ECE0
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$100,d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Stage_SevenForcesUpdateArtemisBackgroundPlane
; Advances the Artemis foreground motion
Stage_SevenForcesUpdateArtemisForegroundMotion:         ; CODE XREF: Stage_SevenForcesScrollArtemisForeground   p  ; was: sub_ECF4
                tst.w   (dword_FF8066).w
                bne.s   Stage_SevenForcesAdvanceArtemisForegroundMotion
                subi.l  #$E00,(dword_FFA904).w
                cmpi.w  #$E1F8,(dword_FFA904).w
                bpl.s   Stage_SevenForcesArtemisForegroundMotionReturn
                move.w  #2,(dword_FF8066).w
Stage_SevenForcesArtemisForegroundMotionReturn:         ; CODE XREF: Stage_SevenForcesUpdateArtemisForegroundMotion+14   j  ; was: locret_ED10
                                        ; Stage_SevenForcesUpdateArtemisForegroundMotion+36   j
                rts
; ---------------------------------------------------------------------------
Stage_SevenForcesAdvanceArtemisForegroundMotion:        ; CODE XREF: Stage_SevenForcesUpdateArtemisForegroundMotion+4   j  ; was: loc_ED12
                bpl.s   Stage_SevenForcesCheckArtemisForegroundLimit
                addi.l  #$12000,(dword_FFA904).w
Stage_SevenForcesCheckArtemisForegroundLimit:           ; CODE XREF: Stage_SevenForcesAdvanceArtemisForegroundMotion   j  ; was: loc_ED1C
                addi.l  #$E00,(dword_FFA904).w
                cmpi.w  #$E206,(dword_FFA904).w
                bmi.s   Stage_SevenForcesArtemisForegroundMotionReturn
                clr.w   (dword_FF8066).w
                rts
; End of function Stage_SevenForcesUpdateArtemisForegroundMotion
; Advances and renders the Sirene primary plane
Stage_SevenForcesUpdateSirenePrimaryPlane:              ; CODE XREF: Stage_SevenForcesAdvanceSireneTransition+6   p  ; was: sub_ED32
                move.l  (dword_FF9614).w,d0
                addi.l  #$200,d0
                cmpi.l  #$8000,d0
                bmi.s   Stage_SevenForcesStoreSirenePrimaryVelocity
                move.l  #$8000,d0
Stage_SevenForcesStoreSirenePrimaryVelocity:            ; CODE XREF: Stage_SevenForcesUpdateSirenePrimaryPlane+10   j  ; was: loc_ED4A
                move.l  d0,(dword_FF9614).w
                add.l   d0,(dword_FFA904).w
                cmpi.w  #$E4C0,(dword_FFA904).w
                bmi.s   Stage_SevenForcesRenderSirenePrimaryPlane
                move.b  #1,(byte_FFA958).w
                move.w  #8,(word_FFA010).w
                bsr.w   Gfx_ClearSevenForcesTilemapMode
Stage_SevenForcesRenderSirenePrimaryPlane:              ; CODE XREF: Stage_SevenForcesUpdateSirenePrimaryPlane+26   j  ; was: loc_ED6A
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$100,d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Stage_SevenForcesUpdateSirenePrimaryPlane
; Advances and renders the Sirene secondary plane
Stage_SevenForcesRenderSireneSecondaryPlane:            ; CODE XREF: Stage_SevenForcesFinishSireneTransition+6   p  ; was: sub_ED7E
                move.l  (dword_FF961C).w,d0
                add.l   d0,(dword_FFA904).w
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                subi.w  #$100,d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Stage_SevenForcesRenderSireneSecondaryPlane
; Advances the Sirene secondary scroll
Stage_SevenForcesUpdateSireneSecondaryScroll:           ; CODE XREF: Stage_SevenForcesAdvanceSireneTransition+2   p  ; was: sub_ED9A
                                        ; Stage_SevenForcesFinishSireneTransition+2   p
                move.l  (dword_FF961C).w,d0
                subi.l  #$100,d0
                cmpi.l  #$FFFFC000,d0
                bpl.s   Stage_SevenForcesStoreSireneSecondaryVelocity
                move.l  #$FFFFC000,d0
Stage_SevenForcesStoreSireneSecondaryVelocity:          ; CODE XREF: Stage_SevenForcesUpdateSireneSecondaryScroll+10   j  ; was: loc_EDB2
                move.l  d0,(dword_FF961C).w
                add.l   d0,(dword_FFA90C).w
                cmpi.w  #$E340,(dword_FFA90C).w
                bpl.s   Stage_SevenForcesRenderSireneSecondaryScroll
                move.b  #1,(byte_FFA958).w
Stage_SevenForcesRenderSireneSecondaryScroll:           ; CODE XREF: Stage_SevenForcesUpdateSireneSecondaryScroll+26   j  ; was: loc_EDC8
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                subi.w  #$100,d1
                lea     (Gfx_FrontendAlternateVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Stage_SevenForcesUpdateSireneSecondaryScroll
UnreferencedSevenForcesEmptyHandler:                    ; was: nullsub_28
                rts
; End of function UnreferencedSevenForcesEmptyHandler

; Camera scroll handler 1
Cutscene_SevenForcesCamera1:                            ; CODE XREF: Cutscene_SevenForcesVictoryState0+4   p  ; was: sub_EDE0
                addi.l  #$78000,(dword_FFA904).w
                cmpi.w  #$E520,(dword_FFA904).w
                bmi.s   Cutscene_SevenForcesCamera1Render
                move.b  #1,(byte_FFA958).w
Cutscene_SevenForcesCamera1Render:                      ; CODE XREF: Cutscene_SevenForcesCamera1+E   j  ; was: loc_EDF6
                moveq   #0,d0
                move.w  (dword_FFA904).w,d1
                addi.w  #$F8,d1
                lea     (Gfx_DefaultVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Cutscene_SevenForcesCamera1
; Camera scroll handler 2
Cutscene_SevenForcesCamera2:                            ; CODE XREF: Cutscene_SevenForcesVictoryState0   p  ; was: sub_EE0A
                                        ; Cutscene_SevenForcesVictoryState1   p
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$E4F8,(dword_FFA90C).w
                bmi.s   Cutscene_SevenForcesCamera2Render
                move.b  #1,(byte_FFA958).w
Cutscene_SevenForcesCamera2Render:                      ; CODE XREF: Cutscene_SevenForcesCamera2+E   j  ; was: loc_EE20
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                addi.w  #$F8,d1
                lea     (Gfx_FrontendAlternateVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Cutscene_SevenForcesCamera2
; Camera scroll handler 3
Cutscene_SevenForcesCamera3:                            ; CODE XREF: Cutscene_SevenForcesVictoryState6+4   p  ; was: sub_EE36
                addi.l  #$78000,(dword_FFA90C).w
                cmpi.w  #$E700,(dword_FFA90C).w
                bmi.s   Cutscene_SevenForcesCamera3Render
                move.b  #1,(byte_FFA958).w
Cutscene_SevenForcesCamera3Render:                      ; CODE XREF: Cutscene_SevenForcesCamera3+E   j  ; was: loc_EE4C
                move.w  #$200,d0
                move.w  (dword_FFA90C).w,d1
                addi.w  #$F8,d1
                lea     (Gfx_FrontendAlternateVRAMTransferParameters).l,a0
                bra.w   Tilemap_QueueRowFromDescriptor
; End of function Cutscene_SevenForcesCamera3
; Initializes the Artemis camera, tilemap, and graphics transfers
Stage_SevenForcesInitializeArtemisCameraAndAssets:      ; CODE XREF: Stage_SevenForcesFinishSylpheedForeground+10   j  ; was: sub_EE62
                bsr.w   Gfx_InitializeArtemisTilemapRow
                bset    #6,(byte_FF8245).w
                move.w  #$60,(dword_FFA900).w           ; '`'
                move.w  #$60,(word_FFA928).w            ; '`'
                move.w  #$E300,(dword_FFA904).w
                move.w  #$E300,(word_FFA92C).w
                clr.w   (dword_FFA908).w
                move.w  #$E400,(dword_FFA90C).w
                move.w  (dword_FFA900).w,(word_FFA970).w
                move.w  (dword_FFA900).w,(word_FFA974).w
                lea     Gfx_ArtemisInitialAssetTransfers(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Stage_SevenForcesInitializeArtemisCameraAndAssets
; ---------------------------------------------------------------------------
Gfx_ArtemisInitialAssetTransfers:   dc.w    7           ; field_0 ; was: stru_EEA6
                                        ; DATA XREF: Stage_SevenForcesInitializeArtemisCameraAndAssets+38   o
                dc.l    tiles_1B6F86                    ; field_2
                dc.w    0                               ; field_6
                dc.w    7                               ; field_0
                dc.l    tiles_1B8CBC                    ; field_2
                dc.w    $1F00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BB632                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BB6A4                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B82E8                     ; field_2
                dc.w    $6800                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1B83A8                     ; field_2
                dc.w    $2020                           ; field_6
                dc.w    $FFFF

; Initializes the Artemis tilemap transfer
Gfx_ArtemisInitializeTilemap:                           ; CODE XREF: Stage_SevenForcesBeginArtemisTransition   p  ; was: sub_EED8
                tst.w   (word_FFF720).w
                bmi.s   Gfx_ArtemisTilemapInitReturn
                movea.l #$FFFF4020,a0
                move.w  #0,d0
                move.w  #$F8,d1
                moveq   #$47,d7                         ; 'G'
                jsr     (Gfx_UpdateTilemapIndices).l
                movea.l #$FFFF4920,a0
                move.w  #$A000,d0
                move.w  #$F8,d1
                moveq   #1,d7
                jsr     (Gfx_UpdateTilemapIndices).l
                move.l  #Gfx_FrontendAlternateVRAMTransferParameters,(dword_FFA940).w
                move.w  #$200,(word_FFA946).w
                move.w  #$E400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #1,d0
Gfx_ArtemisTilemapInitReturn:                           ; CODE XREF: Gfx_ArtemisInitializeTilemap+4   j  ; was: locret_EF26
                rts
; End of function Gfx_ArtemisInitializeTilemap
; Advances the Artemis scrolling-background renderer
Gfx_ArtemisUpdateBackground:                            ; CODE XREF: Stage_SevenForcesWaitForArtemisBackground   p  ; was: sub_EF28
                jsr     (Tilemap_QueueNextScrollingRow).l
                bpl.s   Gfx_ArtemisBackgroundUpdateReturn
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                move.w  #$E400,(word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #$FFFFFFFF,d0
Gfx_ArtemisBackgroundUpdateReturn:                      ; CODE XREF: Gfx_ArtemisUpdateBackground+6   j  ; was: locret_EF4A
                rts
; End of function Gfx_ArtemisUpdateBackground
; Queues the Artemis indexed tilemap rows
Gfx_QueueArtemisIndexedRows:                            ; CODE XREF: Entity_SevenForcesArtemisFadeOutState28+20   p  ; was: sub_EF4C
                lea     Gfx_ArtemisIndexedRowTransferDescriptor(pc),a0
                nop
                jmp     Tilemap_QueueIndexedRows
; End of function Gfx_QueueArtemisIndexedRows
; ---------------------------------------------------------------------------
Gfx_ArtemisIndexedRowTransferDescriptor:    dc.w    $6C00, $4000, $F00, $494A, $494A, $494A, $494A, $494A, $494A, $494A, $494A  ; was: word_EF58
                                        ; DATA XREF: Gfx_QueueArtemisIndexedRows   o

; Checks whether the Seven Forces background render completed
Gfx_CheckSevenForcesBackgroundRender:
                jsr     (Tilemap_QueueNextScrollingRow).l  ; was: sub_EF6E
                bpl.s   Gfx_SevenForcesBackgroundCheckReturn
                moveq   #$FFFFFFFF,d0
Gfx_SevenForcesBackgroundCheckReturn:                   ; CODE XREF: Gfx_CheckSevenForcesBackgroundRender+6   j  ; was: locret_EF78
                rts
; End of function Gfx_CheckSevenForcesBackgroundRender
; Loads cutscene graphics
Cutscene_SevenForcesLoadGraphics:                       ; CODE XREF: Cutscene_SevenForcesVictoryState2+1A   p  ; was: sub_EF7A
                lea     (SevenForcesCutscenePaletteOffsetList).l,a4
                jsr     (Gfx_LoadMultiplePalettes).l
                lea     Gfx_SevenForcesCutsceneAssetTransfers(pc),a0
                nop
                jmp     (Data_ProcessPointer).l
; End of function Cutscene_SevenForcesLoadGraphics
; ---------------------------------------------------------------------------
Gfx_SevenForcesCutsceneAssetTransfers:  dc.w    7       ; field_0 ; was: stru_EF92
                                        ; DATA XREF: Cutscene_SevenForcesLoadGraphics+C   o
                dc.l    tiles_1BBC4E                    ; field_2
                dc.w    $1F00                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BCFFE                     ; field_2
                dc.w    $6000                           ; field_6
                dc.w    6                               ; field_0
                dc.l    byte_1BD048                     ; field_2
                dc.w    $4020                           ; field_6
                dc.w    $FFFF

; Initializes tilemap update with scroll parameters
Gfx_InitializeSevenForcesCutsceneTilemap:               ; CODE XREF: Cutscene_SevenForcesVictoryState3+C   p  ; was: sub_EFAC
                tst.w   (word_FFF720).w
                bmi.s   Gfx_SevenForcesCutsceneTilemapInitReturn
                movea.l #$FFFF4020,a0
                move.w  #0,d0
                move.w  #$F8,d1
                moveq   #$7E,d7                         ; '~'
                jsr     (Gfx_UpdateTilemapIndices).l
                move.l  #Gfx_DefaultVRAMTransferParameters,(dword_FFA940).w
                clr.w   (word_FFA946).w
                clr.w   (word_FFA948).w
                move.w  #$1F,(word_FFA944).w
                moveq   #1,d0
Gfx_SevenForcesCutsceneTilemapInitReturn:               ; CODE XREF: Gfx_InitializeSevenForcesCutsceneTilemap+4   j  ; was: locret_EFE0
                rts
; End of function Gfx_InitializeSevenForcesCutsceneTilemap
; Attributes: thunk
; Checks cutscene completion
Gfx_CheckSevenForcesCutsceneBackgroundComplete:         ; CODE XREF: Cutscene_SevenForcesVictoryState4+C   p  ; was: sub_EFE2
                jmp     Tilemap_QueueNextScrollingRow
; End of function Gfx_CheckSevenForcesCutsceneBackgroundComplete
; Fills the four Stage 20 plane buffers
Gfx_FillStage20PlaneBuffers:                            ; CODE XREF: Stage_SevenForcesInitializeStage20+1A   p  ; was: sub_EFE8
                move.b  #$82,(byte_FF7981).l
                move.b  #$90,(byte_FF7982).l
                move.b  #$92,(byte_FF7983).l
                lea     (word_FF0C80).l,a0
                lea     (word_FF0D00).l,a1
                lea     (word_FF0D80).l,a2
                lea     (word_FF0E00).l,a3
                move.w  #$181,d1
                moveq   #$3F,d7                         ; '?'
Gfx_FillStage20PlaneBuffersLoop:                        ; CODE XREF: Gfx_FillStage20PlaneBuffers+3E   j  ; was: loc_F01E
                move.w  d1,(a0)+
                move.w  d1,(a1)+
                move.w  d1,(a2)+
                move.w  d1,(a3)+
                dbf     d7,Gfx_FillStage20PlaneBuffersLoop
                rts
; End of function Gfx_FillStage20PlaneBuffers
; Background graphics setup
Gfx_ClearSylpheedPlaneModes:                            ; CODE XREF: Stage_SevenForcesInitializeSylpheedScroll+16   p  ; was: sub_F02C
                clr.b   (byte_FF7981).l
                clr.b   (byte_FF7982).l
                clr.b   (byte_FF7983).l
                rts
; End of function Gfx_ClearSylpheedPlaneModes
; Initializes the Artemis tilemap row
Gfx_InitializeArtemisTilemapRow:                        ; CODE XREF: Stage_SevenForcesInitializeArtemisCameraAndAssets   p  ; was: sub_F040
                move.b  #2,(byte_FF7B00).l
                lea     (word_FF0B00).l,a0
                move.w  #$300,d1
                moveq   #$3F,d7                         ; '?'
Gfx_FillArtemisTilemapRowLoop:                          ; CODE XREF: Gfx_InitializeArtemisTilemapRow+16   j  ; was: loc_F054
                move.w  d1,(a0)+
                dbf     d7,Gfx_FillArtemisTilemapRowLoop
                rts
; End of function Gfx_InitializeArtemisTilemapRow
; Clears byte flag at FF7B00
Gfx_ClearSevenForcesTilemapMode:                        ; CODE XREF: Stage_SevenForcesUpdateSirenePrimaryPlane+34   p  ; was: sub_F05C
                clr.b   (byte_FF7B00).l
                rts
; End of function Gfx_ClearSevenForcesTilemapMode
; Unreferenced helper that clamps and applies a palette fade
UnreferencedClampAndApplyPaletteFade:
                move.w  (word_FF9620).w,d0              ; was: sub_F064
                bpl.s   UnreferencedClampPaletteFadePositive
                cmpi.w  #$FFE4,d0
                bpl.s   UnreferencedApplyClampedPaletteFade
                moveq   #$FFFFFFE4,d0
                bra.s   UnreferencedApplyClampedPaletteFade
; ---------------------------------------------------------------------------
UnreferencedClampPaletteFadePositive:                   ; CODE XREF: UnreferencedClampAndApplyPaletteFade+4   j  ; was: loc_F074
                beq.s   UnreferencedApplyClampedPaletteFade
                moveq   #0,d0
UnreferencedApplyClampedPaletteFade:                    ; CODE XREF: UnreferencedClampAndApplyPaletteFade+A   j  ; was: loc_F078
                                        ; UnreferencedClampAndApplyPaletteFade+E   j
                move.w  d0,(word_FF9620).w
                movea.w #(PaletteActiveBuffer-M68K_RAM),a0
                moveq   #$1F,d5
                move.w  #$E000,d7
                jmp     (Gfx_ApplyPaletteFade).l
; End of function UnreferencedClampAndApplyPaletteFade
; Dampens the shared horizontal velocity toward zero
Stage_SevenForcesDampenHorizontalVelocity:              ; CODE XREF: Stage_SevenForcesBeginArtemisTransition+4   p  ; was: sub_F08C
                tst.l   (dword_FF8240).w
                beq.s   Stage_SevenForcesHorizontalVelocityDampingReturn
                bpl.s   Stage_SevenForcesDampenPositiveHorizontalVelocity
                addi.l  #$800,(dword_FF8240).w
                bmi.s   Stage_SevenForcesHorizontalVelocityDampingReturn
                clr.l   (dword_FF8240).w
                rts
; ---------------------------------------------------------------------------
Stage_SevenForcesDampenPositiveHorizontalVelocity:      ; CODE XREF: Stage_SevenForcesDampenHorizontalVelocity+6   j  ; was: loc_F0A4
                subi.l  #$800,(dword_FF8240).w
                bpl.s   Stage_SevenForcesHorizontalVelocityDampingReturn
                clr.l   (dword_FF8240).w
Stage_SevenForcesHorizontalVelocityDampingReturn:       ; CODE XREF: Stage_SevenForcesDampenHorizontalVelocity+4   j  ; was: locret_F0B2
                                        ; Stage_SevenForcesDampenHorizontalVelocity+10   j
                rts
; End of function Stage_SevenForcesDampenHorizontalVelocity
; Updates the Sylpheed foreground scroll velocity and position
Stage_SevenForcesUpdateSylpheedForegroundScroll:        ; CODE XREF: Stage_SevenForcesAdvanceSylpheedForeground:Stage_SevenForcesUpdateSylpheedForeground   j  ; was: sub_F0B4
                btst    #3,(word_FFA40E).w
                bne.s   Stage_SevenForcesIncreaseSylpheedForegroundVelocity
                subi.l  #$1000,(dword_FF8240).w
                bpl.s   Stage_SevenForcesApplySylpheedForegroundVelocity
                clr.l   (dword_FF8240).w
                bra.s   Stage_SevenForcesApplySylpheedForegroundVelocity
; ---------------------------------------------------------------------------
Stage_SevenForcesIncreaseSylpheedForegroundVelocity:    ; CODE XREF: Stage_SevenForcesUpdateSylpheedForegroundScroll+6   j  ; was: loc_F0CC
                addi.l  #$2000,(dword_FF8240).w
                cmpi.w  #4,(dword_FF8240).w
                bmi.s   Stage_SevenForcesApplySylpheedForegroundVelocity
                move.l  #$40000,(dword_FF8240).w
Stage_SevenForcesApplySylpheedForegroundVelocity:       ; CODE XREF: Stage_SevenForcesUpdateSylpheedForegroundScroll+10   j  ; was: loc_F0E4
                                        ; Stage_SevenForcesUpdateSylpheedForegroundScroll+16   j
                move.l  (dword_FF8240).w,d0
                asl.l   #1,d0
                add.l   d0,(dword_FFA908).w
                rts
; End of function Stage_SevenForcesUpdateSylpheedForegroundScroll
