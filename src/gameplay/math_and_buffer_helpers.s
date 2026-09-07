Math_LookupCosineValue:                              ; CODE XREF: Results_RenderScoreValues+1C   p  ; was: sub_1B404
                lea     (word_5A43E).l,a0
                move.w  (a0,d0.w),d0
                rts
; End of function Math_LookupCosineValue
; Calculates distance between two objects using position differences
Physics_CalculateDistanceTo:                              ; CODE XREF: Boss_JetsripperMain:loc_2B72E   p  ; was: sub_1B410
                                        ; sub_2B77C:loc_2B7EA   p ...
                movea.w #(word_FFA400-M68K_RAM),a0
                move.w  $10(a0),d1
                sub.w   $10(a5),d1
                move.w  d1,d0
                bpl.s   loc_1B422
                neg.w   d0
loc_1B422:                              ; CODE XREF: Physics_CalculateDistanceTo+E   j
                move.w  $14(a0),d2
                sub.w   $14(a5),d2
                moveq   #1,d3
                rts
; End of function Physics_CalculateDistanceTo
; Calculates angle using arctan2
Math_CalcAngleBetweenObjs:
                move.w  $10(a0),d0  ; was: sub_1B42E
                move.w  $14(a0),d1
                sub.w   $10(a1),d0
                sub.w   $14(a1),d1
                jsr (Math_Arctan2Lookup).l
                asr.w   #7,d2
                andi.w  #$1FE,d2
                rts
; End of function Math_CalcAngleBetweenObjs
; Calculates sine/cosine values in all four quadrants and stores in lookup tables
Math_CalculateSineCosineTable:                              ; CODE XREF: Boss_ShiperInit+26   j  ; was: sub_1B44C
                                        ; Boss_FlyingNeoInit+1C   p
                movea.w a0,a1
                adda.w  #$200,a1
                movea.w a1,a2
                addq.w  #4,a1
                movea.w a0,a3
                adda.w  #$400,a3
                movea.w a3,a4
                addq.w  #4,a3
                move.w  a5,(dword_FF8040).w
                movea.l #word_1B494,a5
                asl.w   #2,d0
                move.w  #$3F,d7 ; '?'
; Populates sine/cosine lookup table with calculated values
Math_PopulateTrigTable:                              ; CODE XREF: Math_CalculateSineCosineTable+34   j  ; was: loc_1B470
                move.w  (a5)+,d1
                muls.w  d0,d1
                move.l  d1,(a0)+
                move.l  d1,-(a1)
                move.l  d1,(a4)+
                neg.l   d1
                move.l  d1,(a2)+
                move.l  d1,-(a3)
                dbf d7,Math_PopulateTrigTable
                move.w  (a5)+,d1
                muls.w  d0,d1
                move.l  d1,(a0)+
                neg.l   d1
                move.l  d1,(a2)+
                movea.w (dword_FF8040).w,a5
                rts
; End of function Math_CalculateSineCosineTable
; ---------------------------------------------------------------------------
word_1B494:     dc.w 0, $192, $323, $4B5, $645, $7D5, $964, $AF1
                                        ; DATA XREF: Math_LookupSineTable   o
                                        ; Enemy_SpawnProjectileAtAngle+3A   r ...
                dc.w $C7C, $E05, $F8C, $1111, $1294, $1413, $158F, $1708
                dc.w $187D, $19EF, $1B5D, $1CC6, $1E2B, $1F8B, $20E7, $223D
                dc.w $238E, $24DA, $261F, $275F, $2899, $29CD, $2AFA, $2C21
                dc.w $2D41, $2E5A, $2F6B, $3076, $3179, $3274, $3367, $3453
                dc.w $3536, $3612, $36E5, $37AF, $3871, $392A, $39DA, $3A82
                dc.w $3B20, $3BB6, $3C42, $3CC5, $3D3E, $3DAE, $3E14, $3E71
                dc.w $3EC5, $3F0E, $3F4E, $3F84, $3FB1, $3FD3, $3FEC, $3FFB
word_1B514:	binclude	"data/other/word_1B514.bin"
word_1B514_End:


; Loop clearing table entries
Data_ClearTableLoop:                              ; CODE XREF: Data_ClearTableLoop+C   j  ; was: sub_1B714
                bsr.w Data_CheckAndResetEntry
                lea     $60(a0),a0
                cmpa.w  #$DCA0,a0
                bmi.w Data_ClearTableLoop
                rts
; End of function Data_ClearTableLoop
; Check and reset table entry
Data_CheckAndResetEntry:                              ; CODE XREF: Data_ClearTableLoop   p  ; was: sub_1B726
                cmpi.w  #0,(a0)
                beq.w   locret_1B744
                cmp.w   (a0),d0
                beq.w   locret_1B744
                cmp.w   (a0),d1
                beq.w   locret_1B744
                move.w  #$10,(a0)
                move.w  #$1000,2(a0)
locret_1B744:                           ; CODE XREF: Data_CheckAndResetEntry+4   j
                                        ; Data_CheckAndResetEntry+A   j ...
                rts
; End of function Data_CheckAndResetEntry
; Clears boss entity data buffer with zero fill
Sys_ClearBossDataBuffer:                              ; CODE XREF: Cutscene_InitCreditsScreen+44   p  ; was: sub_1B746
                                        ; Cutscene_SegaScreenFadeOut+44   p ...
                moveq   #0,d0
                movea.w #(Entity_ObjectPool-M68K_RAM),a0
loc_1B74C:                              ; CODE XREF: Sys_ClearBossDataBuffer+3A   j
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                move.l  d0,(a0)+
                cmpa.w  #$DCA0,a0
                bmi.s   loc_1B74C
                rts
; End of function Sys_ClearBossDataBuffer
; Queues VDP command for DMA
VDP_QueueCommand:                              ; CODE XREF: Scroll_UpdateSnakeBackground+64   p  ; was: sub_1B784
                move.w  #$8F02,d3
                movea.w (word_FFF70E).w,a0
loc_1B78C:                              ; CODE XREF: Boss_ShieldViperRenderBackground+32   j
                                        ; Gfx_Update3DPlanetEffect+190   j ...
                movea.w (word_FFF70C).w,a1
                move.w  d0,d1
                moveq   #0,d2
                roxl.w  #1,d0
                roxl.w  #1,d2
                roxl.w  #1,d0
                roxl.w  #1,d2
                ori.w   #$80,d2
                move.w  d2,-(a1)
                andi.w  #$3FFF,d1
                addi.w  #$4000,d1
                move.w  d1,-(a1)
                move.l  a0,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                andi.b  #$7F,d2
                move.b  d0,-(a1)
                move.b  #$95,-(a1)
                move.b  d1,-(a1)
                move.b  #$96,-(a1)
                move.b  d2,-(a1)
                move.b  #$97,-(a1)
                move.w  d3,-(a1)
                move.l  d4,-(a1)
                move.w  a1,(word_FFF70C).w
                rts
; End of function VDP_QueueCommand
; Graphics update 2
Stage22_GraphicsUpdate2:                              ; CODE XREF: Stage_LoadTiles2+54   j  ; was: sub_1B7DC
                move.w  #$8F02,d3
                move    sr,-(sp)
                move    #$2700,sr
loc_1B7E6:                              ; CODE XREF: Stage22_GraphicsUpdate2+12   j
                bset    #0,(IO_Z80BUS).l
                bne.s   loc_1B7E6
                lea     (VDP_CTRL).l,a4
                move.w  (word_FFF7D2).w,d2
                bset    #4,d2
                move.w  d2,(a4)
                move.w  d3,(a4)
                move.l  d4,(a4)
                move.l  a0,d0
                lsr.l   #1,d0
                move.l  d0,(dword_FF8040).w
                move.b  (dword_FF8040+2).w,d1
                move.b  (dword_FF8040+1).w,d2
                andi.w  #$FF,d0
                andi.w  #$FF,d1
                andi.w  #$7F,d2
                addi.w  #-$6B00,d0
                addi.w  #-$6A00,d1
                addi.w  #-$6900,d2
                move.w  d0,(a4)
                move.w  d1,(a4)
                move.w  d2,(a4)
                move.w  d5,d1
                moveq   #0,d2
                roxl.w  #1,d5
                roxl.w  #1,d2
                roxl.w  #1,d5
                roxl.w  #1,d2
                ori.w   #$80,d2
                move.w  d2,(VDPCommand).w
                andi.w  #$3FFF,d1
                addi.w  #$4000,d1
                move.w  d1,(VDPCommand+2).w
                move.w  (VDPCommand+2).w,(a4)
                move.w  (VDPCommand).w,(a4)
                move.w  (word_FFF7D2).w,d0
                bclr    #4,d0
                move.w  d0,(a4)
loc_1B864:                              ; CODE XREF: Stage22_GraphicsUpdate2+90   j
                bclr    #0,(IO_Z80BUS).l
                beq.s   loc_1B864
                move    (sp)+,sr
                rts
; End of function Stage22_GraphicsUpdate2
; Calculate tile offset mask $1C0
Math_CalcTileOffset1:
                asr.w   #7,d2  ; was: sub_1B872
                andi.w  #$1FE,d2
                move.w  d2,d0
                addi.w  #$20,d0 ; ' '
                andi.w  #$1C0,d0
                rts
; End of function Math_CalcTileOffset1
; Calculate tile offset mask $1E0
Math_CalcTileOffset2:
                asr.w   #7,d2  ; was: sub_1B884
                andi.w  #$1FE,d2
                move.w  d2,d0
                addi.w  #$10,d0
                andi.w  #$1E0,d0
                rts
; End of function Math_CalcTileOffset2
; Calculate tile offset mask $1F0
Math_CalcTileOffset3:
                asr.w   #7,d2  ; was: sub_1B896
                andi.w  #$1FE,d2
                move.w  d2,d0
                addq.w  #8,d0
                andi.w  #$1F0,d0
                rts
; End of function Math_CalcTileOffset3
; Clear 8KB RAM buffer at FF8000
Sys_ClearRAMBuffer8K:
                movea.w #(dword_FF8000-M68K_RAM),a0  ; was: sub_1B8A6
                moveq   #0,d0
                move.w  #$7FF,d7
loc_1B8B0:                              ; CODE XREF: Sys_ClearRAMBuffer8K+C   j
                move.l  d0,(a0)+
                dbf     d7,loc_1B8B0
                rts
; End of function Sys_ClearRAMBuffer8K
; Checks button mode flag before processing input buttons
Input_CheckButtonMode:                              ; CODE XREF: Stage_SnakeTransition+24   p  ; was: sub_1B8B8
                                        ; Stage_BugmaxTransitionCheck+1C   p ...
                btst    #1,(word_FFFF38+1).w
                beq.s   loc_1B8C4
                move.b  #4,d0
loc_1B8C4:                              ; CODE XREF: Input_CheckButtonMode+6   j
                jmp (Input_ProcessButtons).l
; End of function Input_CheckButtonMode
; Maps button input based on game state
Input_GetMappedButton:                              ; CODE XREF: UI_InitializePasswordScreen+56   j  ; was: sub_1B8CA
                                        ; Password_HandleInput+22   j ...
                btst    #1,(word_FFFF38+1).w
                beq.s Input_GetAttackButton
                move.b  #4,d0
                jmp (Input_ProcessButtons).l
; ---------------------------------------------------------------------------
; Gets mapped attack button input based on control configuration
Input_GetAttackButton:                              ; CODE XREF: Input_GetMappedButton+6   j  ; was: loc_1B8DC
                move.w  (StageTableIndex).w,d0
                asr.w   #1,d0
                move.b  byte_1B8EC(pc,d0.w),d0
                jmp (Input_ProcessButtons).l
; End of function Input_GetMappedButton
; ---------------------------------------------------------------------------
byte_1B8EC:     dc.b $81, $81, $81, $81, $81, $81, $81, $89, $89, $86
                                        ; DATA XREF: Input_GetMappedButton+18   r
                dc.b $86, $86, $89, $92, $92, $8B, $8B, $97, $97, 0
                dc.b $93, $93, $89, $8F, $9F, 0


; Initialize object with random params
