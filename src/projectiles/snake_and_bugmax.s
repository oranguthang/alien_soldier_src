Projectile_SnakeDispatcher:                             ; DATA XREF: ROM:off_2C0F8   o  ; was: sub_2C100
                move.w  4(a5),d0
                lea     off_2C10C(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_SnakeDispatcher
; ---------------------------------------------------------------------------
off_2C10C:      dc.w    Projectile_SnakeInit-*          ; DATA XREF: Projectile_SnakeDispatcher+4   o
                dc.w    Projectile_SnakeWait-*
                dc.w    Enemy_CheckHealthThreshold-*

; Initializes Snake projectile
Projectile_SnakeInit:                                   ; DATA XREF: ROM:off_2C10C   o  ; was: sub_2C112
                jsr     (Projectile_UpdateTrajectory).l
                bne.w   nullsub_61
                move.l  #off_E953C,8(a0)
                jsr     (Sprite_InitializeProperties).l
                move.b  (dword_FFFF08).w,d0
                andi.w  #$3F,d0                         ; '?'
                subi.w  #$20,d0                         ; ' '
                move.b  (dword_FFFF08+1).w,d1
                andi.w  #$3F,d1                         ; '?'
                subi.w  #$20,d1                         ; ' '
                add.w   $10(a5),d0
                add.w   $14(a5),d1
                move.w  d0,$10(a0)
                move.w  d1,$14(a0)
                move.w  #2,$48(a5)
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeInit
; Snake projectile wait state
Projectile_SnakeWait:                                   ; DATA XREF: ROM:0002C10E   o  ; was: sub_2C15E
                subq.w  #1,$48(a5)
                bne.w   nullsub_61
                subq.w  #1,$4A(a5)
                bmi.w   loc_2C174
                subq.w  #2,4(a5)
                rts
; ---------------------------------------------------------------------------
loc_2C174:                                              ; CODE XREF: Projectile_SnakeWait+C   j
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeWait
; Spawns 3-way projectile pattern
Projectile_SnakeSpawn3Way:                              ; DATA XREF: ROM:0002C0FA   o  ; was: sub_2C17A
                tst.w   4(a5)
                bne.w   nullsub_61
                move.w  (dword_FFFF08).w,d2
                andi.w  #$1FE,d2
                move.w  d2,$58(a5)
                move.w  #1,d0
                move.w  #1,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w   Projectile_SpawnMultiPattern
                move.w  #1,d0
                move.w  #3,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w   Projectile_SpawnMultiPattern
                move.w  #1,d0
                move.w  #5,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w   Projectile_SpawnMultiPattern
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeSpawn3Way
; Spawns 6-way projectile pattern
Projectile_SnakeSpawn6Way:                              ; DATA XREF: ROM:0002C0FC   o  ; was: sub_2C1D6
                tst.w   4(a5)
                bne.w   nullsub_61
                move.w  (dword_FFFF08).w,d2
                andi.w  #$1FE,d2
                move.w  d2,$58(a5)
                move.w  #2,d0
                move.w  #3,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w   Projectile_SpawnMultiPattern
                move.w  #2,d0
                move.w  #5,d1
                move.w  $58(a5),d2
                addi.w  #$40,d2                         ; '@'
                andi.w  #$1FE,d2
                movea.l #off_E953C,a1
                bsr.w   Projectile_SpawnMultiPattern
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeSpawn6Way
; Spawns 8-way projectile pattern
Projectile_SnakeSpawn8Way:                              ; DATA XREF: ROM:0002C0FE   o  ; was: sub_2C224
                tst.w   4(a5)
                bne.w   nullsub_61
                move.w  (dword_FFFF08).w,d2
                andi.w  #$1FE,d2
                move.w  d2,$58(a5)
                move.w  #3,d0
                move.w  #4,d1
                move.w  $58(a5),d2
                movea.l #off_E953C,a1
                bsr.w   Projectile_SpawnMultiPattern
                addq.w  #2,4(a5)
                rts
; End of function Projectile_SnakeSpawn8Way
; Initializes debris projectile with ID $348, sets velocity values and random timer
Projectile_InitDebris:
                movea.w a5,a0                           ; was: sub_2C254
; Initializes debris projectile object with random timer
Projectile_InitDebrisObject:                            ; CODE XREF: Boss_BugmaxSpawnDebris+30   p  ; was: loc_2C256
                move.w  #$348,(a0)
                move.w  #$F40,2(a0)
                move.w  d0,$4A(a0)
                move.w  d1,$4C(a0)
                move.w  d2,$4E(a0)
                jsr     (RandomNumber).l
                move.w  (dword_FFFF08).w,d0
                andi.w  #$1F,d0
                move.w  d0,$48(a0)
                rts
; End of function Projectile_InitDebris
; Main Bugmax projectile handler
Projectile_BugmaxMain:                                  ; DATA XREF: ROM:off_5DC   o  ; was: sub_2C280
                subq.w  #1,$4A(a5)
                bpl.s   Projectile_DispatchBugmaxState
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
; Dispatches Bugmax projectile to appropriate state handler
Projectile_DispatchBugmaxState:                         ; CODE XREF: Projectile_BugmaxMain+4   j  ; was: loc_2C28E
                move.w  4(a5),d0
                lea     off_2C29A(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxMain
; ---------------------------------------------------------------------------
off_2C29A:      dc.w    Projectile_BugmaxWait-*         ; DATA XREF: Projectile_BugmaxMain+12   o
                dc.w    Projectile_BugmaxSpawn-*
                dc.w    Projectile_BugmaxWaitLoop-*

; Wait before spawning
Projectile_BugmaxWait:                                  ; DATA XREF: ROM:off_2C29A   o  ; was: sub_2C2A0
                subq.w  #1,$48(a5)
                bpl.s   locret_2C2AA
                addq.w  #2,4(a5)
locret_2C2AA:                                           ; CODE XREF: Projectile_BugmaxWait+4   j
                rts
; End of function Projectile_BugmaxWait
; Spawns child projectiles
Projectile_BugmaxSpawn:                                 ; DATA XREF: ROM:0002C29C   o  ; was: sub_2C2AC
                jsr     (Projectile_UpdateTrajectory).l
                bne.s   locret_2C32A
                jsr     (RandomNumber).l
                btst    #0,(dword_FFFF08).w
                beq.s   loc_2C2CC
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
loc_2C2CC:                                              ; CODE XREF: Projectile_BugmaxSpawn+14   j
                jsr     (Projectile_InitType88).l
                btst    #0,(dword_FFFF08+2).w
                beq.s   loc_2C2E4
                move.l  #off_E953C,8(a0)
                bra.s   Projectile_SpawnAtRandomOffset
; ---------------------------------------------------------------------------
loc_2C2E4:                                              ; CODE XREF: Projectile_BugmaxSpawn+2C   j
                move.l  #off_E95DC,8(a0)
; Spawns projectile at random offset from parent position
Projectile_SpawnAtRandomOffset:                         ; CODE XREF: Projectile_BugmaxSpawn+36   j  ; was: loc_2C2EC
                move.b  (dword_FFFF08).w,d0
                move.w  $4C(a5),d1
                move.w  d1,d2
                subq.w  #1,d1
                and.w   d1,d0
                lsr.w   #1,d2
                sub.w   d2,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (dword_FFFF08+1).w,d0
                move.w  $4E(a5),d1
                move.w  d1,d2
                subq.w  #1,d1
                and.w   d2,d0
                lsr.w   #1,d2
                sub.w   d2,d0
                add.w   $14(a5),d0
                move.w  d0,$14(a0)
                move.w  #8,$50(a5)
                addq.w  #2,4(a5)
locret_2C32A:                                           ; CODE XREF: Projectile_BugmaxSpawn+6   j
                rts
; End of function Projectile_BugmaxSpawn
; Wait loop state
Projectile_BugmaxWaitLoop:                              ; DATA XREF: ROM:0002C29E   o  ; was: sub_2C32C
                subq.w  #1,$50(a5)
                bne.s   locret_2C336
                subq.w  #2,4(a5)
locret_2C336:                                           ; CODE XREF: Projectile_BugmaxWaitLoop+4   j
                rts
; End of function Projectile_BugmaxWaitLoop
nullsub_61:                                             ; CODE XREF: Projectile_ExplodeWithSound+6   j
                                        ; Projectile_ExplodeOnImpact+6   j
                rts
; End of function nullsub_61

; Moves Jetsripper boss left with animation
