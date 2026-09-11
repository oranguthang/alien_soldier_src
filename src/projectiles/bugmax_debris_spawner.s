; Initializes Bugmax debris from the current object
Projectile_InitBugmaxDebrisFromCurrentObject:
                movea.w a5,a0                           ; was: sub_2C254
; Initializes a Bugmax debris spawner with caller-provided dimensions and lifetime
Projectile_InitBugmaxDebris:                            ; CODE XREF: Boss_BugmaxSpawnTransitionDebris+30   p  ; was: loc_2C256
                move.w  #$348,(a0)
                move.w  #$F40,2(a0)
                move.w  d0,$4A(a0)
                move.w  d1,$4C(a0)
                move.w  d2,$4E(a0)
                jsr     (RandomNumber).l
                move.w  (RandomNumberState).w,d0
                andi.w  #$1F,d0
                move.w  d0,$48(a0)
                rts
; End of function Projectile_InitBugmaxDebrisFromCurrentObject
; Updates the timed Bugmax debris-particle spawner
Projectile_BugmaxDebrisSpawner:                         ; DATA XREF: ROM:Entity_UpdateHandlerTable   o  ; was: sub_2C280
                subq.w  #1,$4A(a5)
                bpl.s   Projectile_BugmaxDebrisSpawner_Dispatch
                move.w  #$1000,2(a5)
                rts
; ---------------------------------------------------------------------------
; Dispatches the debris spawner's current state
Projectile_BugmaxDebrisSpawner_Dispatch:                ; CODE XREF: Projectile_BugmaxDebrisSpawner+4   j  ; was: loc_2C28E
                move.w  4(a5),d0
                lea     Projectile_BugmaxDebrisSpawnerStateHandlers(pc,d0.w),a0
                adda.w  (a0),a0
                jmp     (a0)
; End of function Projectile_BugmaxDebrisSpawner
; ---------------------------------------------------------------------------
Projectile_BugmaxDebrisSpawnerStateHandlers:    dc.w    Projectile_BugmaxDebrisSpawner_WaitInitialDelay-*  ; DATA XREF: Projectile_BugmaxDebrisSpawner+12   o  ; was: off_2C29A
                dc.w    Projectile_BugmaxDebrisSpawner_SpawnParticle-*
                dc.w    Projectile_BugmaxDebrisSpawner_WaitBetweenParticles-*

; Waits for the initial randomized delay
Projectile_BugmaxDebrisSpawner_WaitInitialDelay:        ; DATA XREF: ROM:Projectile_BugmaxDebrisSpawnerStateHandlers   o  ; was: sub_2C2A0
                subq.w  #1,$48(a5)
                bpl.s   Projectile_BugmaxDebrisSpawner_WaitInitialDelay_Return
                addq.w  #2,4(a5)
Projectile_BugmaxDebrisSpawner_WaitInitialDelay_Return:  ; CODE XREF: Projectile_BugmaxDebrisSpawner_WaitInitialDelay+4   j  ; was: locret_2C2AA
                rts
; End of function Projectile_BugmaxDebrisSpawner_WaitInitialDelay
; Spawns one debris particle and schedules the next one
Projectile_BugmaxDebrisSpawner_SpawnParticle:           ; DATA XREF: ROM:0002C29C   o  ; was: sub_2C2AC
                jsr     (Projectile_FindFreePrimarySlot).l
                bne.s   Projectile_BugmaxDebrisSpawner_SpawnParticle_Return
                jsr     (RandomNumber).l
                btst    #0,(RandomNumberState).w
                beq.s   Projectile_BugmaxDebrisSpawner_InitializeParticle
                move.b  #$BB,d0
                jsr     (Sound_PlaySFX).l
Projectile_BugmaxDebrisSpawner_InitializeParticle:      ; CODE XREF: Projectile_BugmaxDebrisSpawner_SpawnParticle+14   j  ; was: loc_2C2CC
                jsr     (Projectile_InitType88).l
                btst    #0,(RandomNumberState+2).w
                beq.s   Projectile_BugmaxDebrisSpawner_UseAlternateMapping
                move.l  #SharedCombatSpriteAnimation00,8(a0)
                bra.s   Projectile_BugmaxDebrisSpawner_SetRandomOffset
; ---------------------------------------------------------------------------
Projectile_BugmaxDebrisSpawner_UseAlternateMapping:     ; CODE XREF: Projectile_BugmaxDebrisSpawner_SpawnParticle+2C   j  ; was: loc_2C2E4
                move.l  #SharedCombatSpriteAnimation05,8(a0)
; Positions the particle randomly inside the configured rectangle
Projectile_BugmaxDebrisSpawner_SetRandomOffset:         ; CODE XREF: Projectile_BugmaxDebrisSpawner_SpawnParticle+36   j  ; was: loc_2C2EC
                move.b  (RandomNumberState).w,d0
                move.w  $4C(a5),d1
                move.w  d1,d2
                subq.w  #1,d1
                and.w   d1,d0
                lsr.w   #1,d2
                sub.w   d2,d0
                add.w   $10(a5),d0
                move.w  d0,$10(a0)
                move.b  (RandomNumberState+1).w,d0
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
Projectile_BugmaxDebrisSpawner_SpawnParticle_Return:    ; CODE XREF: Projectile_BugmaxDebrisSpawner_SpawnParticle+6   j  ; was: locret_2C32A
                rts
; End of function Projectile_BugmaxDebrisSpawner_SpawnParticle
; Waits between successive debris particles
Projectile_BugmaxDebrisSpawner_WaitBetweenParticles:    ; DATA XREF: ROM:0002C29E   o  ; was: sub_2C32C
                subq.w  #1,$50(a5)
                bne.s   Projectile_BugmaxDebrisSpawner_WaitBetweenParticles_Return
                subq.w  #2,4(a5)
Projectile_BugmaxDebrisSpawner_WaitBetweenParticles_Return:  ; CODE XREF: Projectile_BugmaxDebrisSpawner_WaitBetweenParticles+4   j  ; was: locret_2C336
                rts
; End of function Projectile_BugmaxDebrisSpawner_WaitBetweenParticles
Object_UpdateNoOpReturn:                                ; CODE XREF: Effect_SpawnExplosionA+6   j  ; was: nullsub_61
                                        ; Effect_SpawnExplosionB+6   j
                rts
; End of function Object_UpdateNoOpReturn
