Demo_PlaybackSystem:                                    ; CODE XREF: Sys_DispatchGameState:Sys_DispatchGameState_Run   p  ; was: sub_23CBA
                tst.w   (word_FFFF5A).w
                beq.w   Demo_PlaybackSystem_Return
                move.w  #0,(word_FFFF56).w
                tst.w   (word_FFFF5C).w
                bne.w   Demo_PlaybackSystem_Update
                move.l  #$8522BD7A,(dword_FFFF08).w
                clr.w   (word_FFA280).w
                clr.w   (word_FFA000).w
                move.w  (DifficultyMode).w,(word_FFFF5E).w
                move.w  (SoundDisableFlags).w,(word_FFFF60).w
                move.b  (byte_FFFF30).w,(byte_FFFF66).w
                move.w  #2,(DifficultyMode).w
                move.w  #0,(SoundDisableFlags).w
                move.b  #0,(byte_FFFF30).w
                clr.w   (word_FFFF48).w
                move.w  (word_FFFF62).w,d0
                andi.w  #6,d0
                lea     Demo_StageIndexTable(pc),a0
                nop
                move.w  (a0,d0.w),(word_FFFF64).w
                lsl.w   #1,d0
                jsr     Demo_GetInputPointer(pc)        ; (pc)
                nop
                move.w  (a0)+,(word_FFFF4A).w
                move.l  a0,(dword_FFFF4C).w
                move.w  #$1000,(word_FFFF58).w
                addq.w  #4,(word_FFFF5C).w
                tst.w   (word_FFFF56).w
                beq.w   Demo_PlaybackSystem_Return
                clr.w   (word_FFFF50).w
                clr.w   (word_FFFF4A).w
Demo_PlaybackSystem_Return:                             ; CODE XREF: Demo_PlaybackSystem+4   j  ; was: locret_23D46
                                        ; Demo_PlaybackSystem+80   j
                rts
; ---------------------------------------------------------------------------
Demo_PlaybackSystem_Update:                             ; CODE XREF: Demo_PlaybackSystem+12   j  ; was: loc_23D48
                tst.w   (word_FFF720).w
                bmi.w   Demo_PlaybackSystem_UpdateTimer
                btst    #7,(word_FFF708).w
                bne.w   Demo_PlaybackSystem_Exit
Demo_PlaybackSystem_UpdateTimer:                        ; CODE XREF: Demo_PlaybackSystem+92   j  ; was: loc_23D5A
                tst.w   (word_FFFF58).w
                beq.w   Demo_PlaybackSystem_Exit
                cmpi.w  #$80,(word_FFFF58).w
                bne.s   Demo_PlaybackSystem_ProcessInput
                move.b  #1,(byte_FF830E).w
Demo_PlaybackSystem_ProcessInput:                       ; CODE XREF: Demo_PlaybackSystem+AE   j  ; was: loc_23D70
                bsr.w   Demo_HandlePlaybackInput
                tst.w   (word_FFFF56).w
                bne.s   Demo_PlaybackSystem_DecrementTimer
                move.b  (word_FFFF52).w,(word_FFF706).w
                move.b  (word_FFFF52+1).w,(word_FFF708).w
Demo_PlaybackSystem_DecrementTimer:                     ; CODE XREF: Demo_PlaybackSystem+BE   j  ; was: loc_23D86
                subq.w  #1,(word_FFFF58).w
                rts
; ---------------------------------------------------------------------------
Demo_PlaybackSystem_Exit:                               ; CODE XREF: Demo_PlaybackSystem+9C   j  ; was: loc_23D8C
                                        ; Demo_PlaybackSystem+A4   j
                clr.b   (byte_FFF807).w
                move.w  #$14,(GameModeIndex).w
                clr.w   (GameSubstateIndex).w
                clr.w   (word_FFFF5A).w
                clr.w   (word_FFF74A).w
                clr.w   (word_FFF74E).w
                move.w  (word_FFFF5E).w,(DifficultyMode).w
                move.w  (word_FFFF60).w,(SoundDisableFlags).w
                move.b  (byte_FFFF66).w,(byte_FFFF30).w
                addq.w  #2,(word_FFFF62).w
                andi.w  #6,(word_FFFF62).w
                move.b  #4,(dword_FFF80A).w
                lea     (word_FFE300).w,a0
                moveq   #0,d0
                move.w  #$3F,d1                         ; '?'
Demo_PlaybackSystem_ClearBufferLoop:                    ; CODE XREF: Demo_PlaybackSystem+11A   j  ; was: loc_23DD2
                move.l  d0,(a0)+
                dbf     d1,Demo_PlaybackSystem_ClearBufferLoop
                bclr    #6,(word_FFF7D2+1).w
                clr.b   (byte_FFF755).w
                move.w  (word_FFF7D2).w,(VDP_CTRL).l
                move.b  #0,(word_FFF7F4+1).w
                move.w  (word_FFF7F4).w,(VDP_CTRL).l
                move.b  #$10,(word_FFF7DE+1).w
                move.w  (word_FFF7DE).w,(VDP_CTRL).l
                andi.b  #$EF,(word_FFF7D0+1).w
                move.w  (word_FFF7D0).w,(VDP_CTRL).l
                rts
; End of function Demo_PlaybackSystem
; Handles demo playback mode with input recording and frame timing
Demo_HandlePlaybackInput:                               ; CODE XREF: Demo_PlaybackSystem:Demo_PlaybackSystem_ProcessInput   p  ; was: sub_23E16
                tst.w   (word_FFFF56).w
                bne.w   Demo_HandlePlaybackInput_Record
                move.w  (word_FFFF48).w,(word_FFFF52).w
                subq.w  #1,(word_FFFF4A).w
                bne.w   Demo_PlaybackSystem_Return
                movea.l (dword_FFFF4C).w,a0
                move.w  (a0)+,(word_FFFF48).w
                move.w  (a0)+,(word_FFFF4A).w
                move.l  a0,(dword_FFFF4C).w
                rts
; ---------------------------------------------------------------------------
Demo_HandlePlaybackInput_Record:                        ; CODE XREF: Demo_HandlePlaybackInput+4   j  ; was: loc_23E3E
                move.b  (word_FFF706).w,d0
                lsl.w   #8,d0
                move.b  (word_FFF708).w,d0
                cmp.w   (word_FFFF48).w,d0
                bne.s   Demo_HandlePlaybackInput_AppendRecord
                addq.w  #1,(word_FFFF4A).w
                rts
; ---------------------------------------------------------------------------
Demo_HandlePlaybackInput_AppendRecord:                  ; CODE XREF: Demo_HandlePlaybackInput+36   j  ; was: loc_23E54
                lea     ($FFFC0000).l,a1
                movea.w (word_FFFF50).w,a0
                move.w  (word_FFFF4A).w,(a1,a0.w)
                move.w  d0,2(a1,a0.w)
                move.b  (word_FFF706).w,(word_FFFF48).w
                move.b  (word_FFF708).w,(word_FFFF48+1).w
                move.w  #1,(word_FFFF4A).w
                addi.w  #4,(word_FFFF50).w
                rts
; End of function Demo_HandlePlaybackInput
; Returns appropriate input data pointer for demo playback or recording
Demo_GetInputPointer:                                   ; CODE XREF: Demo_PlaybackSystem+64   p  ; was: sub_23E82
                                        ; DATA XREF: Demo_PlaybackSystem+64   o
                tst.w   (word_FFFF56).w
                bne.s   Demo_GetInputPointer_UseRecordingBuffer
                movea.l Demo_InputStreamPointers(pc,d0.w),a0
                rts
; ---------------------------------------------------------------------------
Demo_GetInputPointer_UseRecordingBuffer:                ; CODE XREF: Demo_GetInputPointer+4   j  ; was: loc_23E8E
                lea     ($FFFC0000).l,a0
                rts
; End of function Demo_GetInputPointer
; ---------------------------------------------------------------------------
Demo_StageIndexTable:       dc.w    2, $E, $12, $1E     ; DATA XREF: Demo_PlaybackSystem+56   o  ; was: word_23E96
Demo_InputStreamPointers:   dc.l    Demo_InputStream0   ; DATA XREF: Demo_GetInputPointer+6   r  ; was: off_23E9E
                dc.l    Demo_InputStream1
                dc.l    Demo_InputStream2
                dc.l    Demo_InputStream3
Demo_InputStream0:  binclude "data/other/word_23EAE.bin"  ; was: word_23EAE
Demo_InputStream0_End:                                  ; was: word_23EAE_End
Demo_InputStream1:  binclude "data/other/word_24A50.bin"  ; was: word_24A50
Demo_InputStream1_End:                                  ; was: word_24A50_End
Demo_InputStream2:  binclude "data/other/word_25142.bin"  ; was: word_25142
Demo_InputStream2_End:                                  ; was: word_25142_End
Demo_InputStream3:  binclude "data/other/word_259C8.bin"  ; was: word_259C8
Demo_InputStream3_End:                                  ; was: word_259C8_End

; Decompresses cutscene graphics data
