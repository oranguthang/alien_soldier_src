; Seven Forces post-battle transition controller
; Dispatch the post-battle transition requested by the completed boss
Boss_QueueSevenForcesPostBattleTransition:              ; CODE XREF: Entity_UpdateValkirieBattle+26   j  ; was: sub_555C8
                                        ; Boss_UpdateMedusa+26   j
                bset    #0,(StageTimerPauseFlag).w
                movea.w #(Entity60Type-M68K_RAM),a5
                bsr.s   Entity_DispatchSevenForcesPostBattleTransition
                movea.w #(Entity_ObjectPool-M68K_RAM),a5
                rts
; End of function Boss_QueueSevenForcesPostBattleTransition
; Dispatch a post-battle transition by the caller-supplied even index
Entity_DispatchSevenForcesPostBattleTransition:         ; CODE XREF: Boss_QueueSevenForcesPostBattleTransition+A   p  ; was: sub_555DA
                movea.w Entity_SevenForcesPostBattleTransitionOffsets(pc,d0.w),a1
                adda.l  #Entity_ResetSevenForcesTransitionController,a1
                jmp     (a1)
; End of function Entity_DispatchSevenForcesPostBattleTransition
; ---------------------------------------------------------------------------
Entity_SevenForcesPostBattleTransitionOffsets:  dc.w    Entity_ResetSevenForcesTransitionController-Entity_ResetSevenForcesTransitionController  ; was: off_555E6
                                        ; DATA XREF: Entity_DispatchSevenForcesPostBattleTransition   r
                dc.w    Entity_StartSevenForcesMedusaTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesSylpheedTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesArtemisTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesSireneTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_ResumeSevenForcesIntroState24-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_ResumeSevenForcesIntroState26-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_StartSevenForcesFinalTransition-Entity_ResetSevenForcesTransitionController
                dc.w    Entity_SevenForcesPostBattleNoOp-Entity_ResetSevenForcesTransitionController

; Reset the Seven Forces transition controller state
Entity_ResetSevenForcesTransitionController:            ; DATA XREF: Entity_DispatchSevenForcesPostBattleTransition+4   o  ; was: sub_555F8
                                        ; ROM:Entity_SevenForcesPostBattleTransitionOffsets   o
                move.w  #0,4(a5)
                rts
; End of function Entity_ResetSevenForcesTransitionController
; Start the Medusa form transition after Valkirie completes
Entity_StartSevenForcesMedusaTransition:                ; DATA XREF: ROM:000555E8   o  ; was: sub_55600
                move.w  #$10,4(a5)
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                move.w  #$FFF4,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesMedusaTransition
; Start the Sylpheed form transition after Medusa completes
Entity_StartSevenForcesSylpheedTransition:              ; DATA XREF: ROM:000555EA   o  ; was: sub_5562A
                move.w  #$18,4(a5)
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                lea     (SevenForcesSylpheedTransitionPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (PlaneAScrollModeFlags).w
                clr.b   (PlaneBScrollModeFlags).w
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesSylpheedTransition
; Start the Artemis form transition after Sylpheed completes
Entity_StartSevenForcesArtemisTransition:               ; DATA XREF: ROM:000555EC   o  ; was: sub_5566C
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$22,4(a5)                      ; '"'
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                lea     (SevenForcesArtemisTransitionPaletteCommand).l,a0
                jsr     (Gfx_LoadPaletteCommand).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesArtemisTransition
; Start the Sirene form transition after Artemis completes
Entity_StartSevenForcesSireneTransition:                ; DATA XREF: ROM:000555EE   o  ; was: sub_556A8
                move.w  #$2A,4(a5)                      ; '*'
                bsr.w   Entity_InitSevenForcesTransitionSprite
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_StartSevenForcesSireneTransition
; Resume the intro controller at state $24 and clear obsolete objects
Entity_ResumeSevenForcesIntroState24:                   ; DATA XREF: ROM:000555F0   o  ; was: sub_556D2
                move.w  #$24,4(a5)                      ; '$'
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_ResumeSevenForcesIntroState24
; Resume the intro controller at state $26 and clear obsolete objects
Entity_ResumeSevenForcesIntroState26:                   ; DATA XREF: ROM:000555F2   o  ; was: sub_556F4
                move.w  #$26,4(a5)                      ; '&'
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                move.b  #$30,d0                         ; '0'
                jmp     (Sound_QueueSFXRequest).l
; End of function Entity_ResumeSevenForcesIntroState26
; Start the final explosion sequence after Sirene completes
Entity_StartSevenForcesFinalTransition:                 ; DATA XREF: ROM:000555F4   o  ; was: sub_55716
                move.w  #$36,4(a5)                      ; '6'
                bclr    #0,(PlayerObjectFlags).w
                bset    #0,(PlayerModeFlags).w
                bclr    #2,(PlayerModeFlags).w
                clr.w   $48(a5)
                clr.b   (VDPReg11Shadow+1).w
                clr.b   (PlaneAScrollModeFlags).w
                clr.b   (PlaneBScrollModeFlags).w
                move.b  #1,(SceneSequenceFlags).w
                move.w  #$428,d0
                moveq   #0,d1
                jsr     (Object_ClearEntityRecordsExceptTwoTypes).l
                move.w  #$FFF2,$5E(a5)
                bsr.w   Gfx_UpdateSevenForcesMultiRangePaletteFade
                rts
; End of function Entity_StartSevenForcesFinalTransition
; Intentional no-op post-battle transition entry
Entity_SevenForcesPostBattleNoOp:                       ; DATA XREF: ROM:000555F6   o  ; was: nullsub_127
                rts
; End of function Entity_SevenForcesPostBattleNoOp
