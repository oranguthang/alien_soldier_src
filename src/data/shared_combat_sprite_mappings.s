; Shared combat sprite frames and the relative-offset animation streams that use them
; Numeric suffixes preserve ROM order without guessing a visual identity shared by unrelated users
; Known consumers and unresolved visual roles are recorded in docs/unknowns.md

SharedCombatSpriteFrame00:  dc.w    $5079, $A00, $E8    ; DATA XREF: OrphanedFloatingOscillator+22   o  ; was: word_E907A
                                        ; ROM:000E9544   o
                dc.w    $5879, $A00, 0
                dc.w    $4079, $A00, $E8E8
                dc.w    $C879, $A00, $E800
SharedCombatSpriteFrame01:  dc.w    $5082, $A00, $E8    ; DATA XREF: ROM:000E9548   o  ; was: word_E9092
                                        ; ROM:000E956C   o
                dc.w    $4082, $A00, $E8E8
                dc.w    $5882, $A00, 0
                dc.w    $C882, $A00, $E800
SharedCombatSpriteFrame02:  dc.w    $C88B, $F00, $F0F0  ; DATA XREF: ROM:000E954C   o  ; was: word_E90AA
                                        ; ROM:000E9570   o
SharedCombatSpriteFrame03:  dc.w    $C89B, $F00, $F0F0  ; DATA XREF: ROM:000E9550   o  ; was: word_E90B0
                                        ; ROM:000E9574   o
SharedCombatSpriteFrame04:  dc.w    $C8AB, $F00, $F0F0  ; DATA XREF: ROM:000E9554   o  ; was: word_E90B6
                                        ; ROM:000E9578   o
SharedCombatSpriteFrame05:  dc.w    $C8BB, $F00, $F0F0  ; DATA XREF: ROM:000E9558   o  ; was: word_E90BC
                                        ; ROM:000E955C   o
SharedCombatSpriteFrame06:  dc.w    $C800, $A00, $F4F4  ; DATA XREF: Boss_InitArtemisRadialEmitter+2E   o  ; was: word_E90C2
                                        ; ROM:SharedCombatSpriteAnimation00   o
SharedCombatSpriteFrame07:  dc.w    $C8CB, $F00, $F0F0  ; DATA XREF: ROM:000E9540   o  ; was: word_E90C8
                                        ; ROM:000E9564   o
SharedCombatSpriteFrame08:  dc.w    $C8EC, $F00, $F0F0  ; DATA XREF: ROM:000E95E4   o  ; was: word_E90CE
                                        ; ROM:000E960C   o
SharedCombatSpriteFrame09:  dc.w    $C8FC, $100, $F8FC  ; DATA XREF: ROM:0002B6CC   o  ; was: word_E90D4
                                        ; ROM:SharedCombatSpriteAnimation23   o
SharedCombatSpriteFrame10:  dc.w    $C8FE, $400, $FCF8  ; DATA XREF: ROM:Projectile_WolfGaropaDirectionMappings   o  ; was: word_E90DA
                                        ; ROM:000E977C   o
SharedCombatSpriteFrame11:  dc.w    $C900, $500, $F8F8  ; DATA XREF: ROM:0002B6C8   o  ; was: word_E90E0
                                        ; ROM:000E9778   o
SharedCombatSpriteFrame12:  dc.w    $C100, $500, $F8F8  ; DATA XREF: ROM:0002B6D0   o  ; was: word_E90E6
                                        ; ROM:000E9780   o
SharedCombatSpriteFrame13:  dc.w    $C86C, 0, $FCFC     ; DATA XREF: ROM:SharedCombatSpriteAnimation28   o  ; was: word_E90EC
SharedCombatSpriteFrame14:  dc.w    $C86D, $500, $F8F8  ; DATA XREF: ROM:SharedCombatSpriteAnimation27   o  ; was: word_E90F2
SharedCombatSpriteFrame15:  dc.w    $C871, 0, $FCFC     ; DATA XREF: ROM:000E97E4   o  ; was: word_E90F8
SharedCombatSpriteFrame16:  dc.w    $4873, 0, $FCFC     ; DATA XREF: ROM:000E97A0   o  ; was: word_E90FE
                                        ; ROM:000E97B0   o
                dc.w    $50DB, 0, $F8
                dc.w    $58DB, 0, 0
                dc.w    $40DB, 0, $F8F8
                dc.w    $C8DB, 0, $F800
SharedCombatSpriteFrame17:  dc.w    $4840, $500, $F8F8  ; DATA XREF: ROM:000E97A4   o  ; was: word_E911C
                                        ; ROM:000E97AC   o
                dc.w    $50DB, 0, $F8
                dc.w    $58DB, 0, 0
                dc.w    $40DB, 0, $F8F8
                dc.w    $C8DB, 0, $F800
SharedCombatSpriteFrame18:  dc.w    $50DB, 0, $F8       ; DATA XREF: ROM:SharedCombatSpriteAnimation25   o  ; was: word_E913A
                dc.w    $58DB, 0, 0
                dc.w    $40DB, 0, $F8F8
                dc.w    $C8DB, 0, $F800
SharedCombatSpriteFrame19:  dc.w    $50DC, 0, $F8       ; DATA XREF: ROM:SharedCombatSpriteAnimation26   o  ; was: word_E9152
                dc.w    $58DC, 0, 0
                dc.w    $40DC, 0, $F8F8
                dc.w    $C8DC, 0, $F800
SharedCombatSpriteFrame20:  dc.w    $4856, $A00, $F4F4  ; DATA XREF: ROM:000E97A8   o  ; was: word_E916A
                dc.w    $50DB, 0, $F8
                dc.w    $58DB, 0, 0
                dc.w    $40DB, 0, $F8F8
                dc.w    $C8DB, 0, $F800
SharedCombatSpriteFrame21:  dc.w    $C82C, $500, $F8F8  ; DATA XREF: ROM:000E95A8   o  ; was: word_E9188
                                        ; ROM:000E95C4   o
SharedCombatSpriteFrame22:  dc.w    $C830, $500, $F8F8  ; DATA XREF: ROM:000E95AC   o  ; was: word_E918E
                                        ; ROM:000E95C8   o
SharedCombatSpriteFrame23:  dc.w    $C834, $500, $F8F8  ; DATA XREF: ROM:000E95B0   o  ; was: word_E9194
                                        ; ROM:000E95CC   o
SharedCombatSpriteFrame24:  dc.w    $C838, $500, $F8F8  ; DATA XREF: ROM:000E95B4   o  ; was: word_E919A
                                        ; ROM:000E95D0   o
SharedCombatSpriteFrame25:  dc.w    $C868, $500, $F8F8  ; DATA XREF: ROM:000E95B8   o  ; was: word_E91A0
                                        ; ROM:000E95BC   o
SharedCombatSpriteFrame26:  dc.w    $C809, $A00, $F4F4  ; DATA XREF: ROM:000E95EC   o  ; was: word_E91A6
                                        ; ROM:000E9614   o
SharedCombatSpriteFrame27:  dc.w    $C812, $A00, $F4F4  ; DATA XREF: ROM:000E95F0   o  ; was: word_E91AC
                                        ; ROM:000E9618   o
SharedCombatSpriteFrame28:  dc.w    $C81B, $A00, $F4F4  ; DATA XREF: ROM:000E95F4   o  ; was: word_E91B2
                                        ; ROM:000E961C   o
SharedCombatSpriteFrame29:  dc.w    $C824, $500, $F8F8  ; DATA XREF: ROM:000E95F8   o  ; was: word_E91B8
                                        ; ROM:000E9620   o
SharedCombatSpriteFrame30:  dc.w    $C828, $500, $F8F8  ; DATA XREF: ROM:000E95FC   o  ; was: word_E91BE
                                        ; ROM:000E9600   o
SharedCombatSpriteFrame31:  dc.w    $C83C, $500, $F8F8  ; DATA XREF: ROM:SharedCombatSpriteAnimation07   o  ; was: word_E91C4
                                        ; ROM:SharedCombatSpriteAnimation09   o
SharedCombatSpriteFrame32:  dc.w    $C840, $500, $F8F8  ; DATA XREF: ROM:000E9630   o  ; was: word_E91CA
                                        ; ROM:000E9654   o
SharedCombatSpriteFrame33:  dc.w    $C873, 0, $FCFC     ; DATA XREF: ROM:SharedCombatSpriteAnimation08   o  ; was: word_E91D0
                                        ; ROM:000E9650   o
SharedCombatSpriteFrame34:  dc.w    $C872, 0, $FCFC     ; DATA XREF: ROM:000E9640   o  ; was: word_E91D6
                                        ; ROM:000E9658   o
                dc.w    $4856, $A00, $F4F4
                dc.w    $50DB, 0, $F8
                dc.w    $58DB, 0, 0
                dc.w    $40DB, 0, $F8F8
                dc.w    $C8DB, 0, $F800
SharedCombatSpriteFrame35:  dc.w    $C874, 0, $FCFC     ; DATA XREF: Debug_SetupRadialTestParticleSprite+1E   o  ; was: word_E91FA
                                        ; Boss_GustheadSpawnScrollingDebris+36   o
SharedCombatSpriteFrame36:  dc.w    $C875, 0, $FCFC     ; DATA XREF: ROM:000E9664   o  ; was: word_E9200
                                        ; ROM:000E9670   o
SharedCombatSpriteFrame37:  dc.w    $C856, $A00, $F4F4  ; DATA XREF: ROM:SharedCombatSpriteAnimation12   o  ; was: word_E9206
                                        ; ROM:SharedCombatSpriteAnimation13   o
SharedCombatSpriteFrame38:  dc.w    $C85F, $A00, $F4F4  ; DATA XREF: ROM:000E9684   o  ; was: word_E920C
                                        ; ROM:000E9690   o
SharedCombatSpriteFrame39:  dc.w    $C844, $500, $F8F8  ; DATA XREF: ROM:000E96BC   o  ; was: word_E9212
                                        ; ROM:000E96C8   o
SharedCombatSpriteFrame40:  dc.w    $C871, 0, $FCFC     ; DATA XREF: ROM:000E96C0   o  ; was: word_E9218
                                        ; ROM:000E96C4   o
SharedCombatSpriteFrame41:  dc.w    $C876, 0, $FCFC     ; DATA XREF: ROM:000E96E8   o  ; was: word_E921E
                                        ; ROM:000E96F4   o
SharedCombatSpriteFrame42:  dc.w    $C877, 0, $FCFC     ; DATA XREF: ROM:000E96E4   o  ; was: word_E9224
                                        ; ROM:000E9754   o
SharedCombatSpriteFrame43:  dc.w    $4873, 0, $FCFC     ; DATA XREF: ROM:000E97BC   o  ; was: word_E922A
                                        ; ROM:000E97CC   o
                dc.w    $50DC, 0, $F8
                dc.w    $58DC, 0, 0
                dc.w    $40DC, 0, $F8F8
                dc.w    $C8DC, 0, $F800
SharedCombatSpriteFrame44:  dc.w    $4840, $500, $F8F8  ; DATA XREF: ROM:000E97C0   o  ; was: word_E9248
                                        ; ROM:000E97C8   o
                dc.w    $50DC, 0, $F8
                dc.w    $58DC, 0, 0
                dc.w    $40DC, 0, $F8F8
                dc.w    $C8DC, 0, $F800
SharedCombatSpriteFrame45:  dc.w    $4856, $A00, $F4F4  ; DATA XREF: ROM:000E97C4   o  ; was: word_E9266
                dc.w    $50DC, 0, $F8
                dc.w    $58DC, 0, 0
                dc.w    $40DC, 0, $F8F8
                dc.w    $C8DC, 0, $F800
SharedCombatSpriteFrame46:  dc.w    $48E3, $A00, $FEFE  ; DATA XREF: ROM:000E97F4   o  ; was: word_E9284
                dc.w    $D0E3, $A00, $EAEA
SharedCombatSpriteFrame47:  dc.w    $40E0, $800, $FCE8  ; DATA XREF: ROM:000E97F0   o  ; was: word_E9290
                dc.w    $C8E0, $800, $FC00
SharedCombatSpriteFrame48:  dc.w    $58DD, $200, $E8FC  ; DATA XREF: ROM:SharedCombatSpriteAnimation29   o  ; was: word_E929C
                dc.w    $C8DD, $200, $FC
                dc.w    $48E3, $A00, $EAEC
                dc.w    $50E3, $A00, $D6D8
                dc.w    $48E3, $A00, $1214
                dc.w    $D0E3, $A00, $FE00
                dc.w    $40E0, $800, $FCD0
                dc.w    $48E0, $800, $FCE8
                dc.w    $40E0, $800, $FC00
                dc.w    $C8E0, $800, $FC18
                dc.w    $58DD, $200, $FC
                dc.w    $48DD, $200, $18FC
                dc.w    $58DD, $200, $D0FC
                dc.w    $C8DD, $200, $E8FC
SharedCombatSpriteFrame49:  dc.w    $4809, $A00, $F409  ; DATA XREF: ROM:SharedCombatSpriteAnimation31   o  ; was: word_E92F0
                dc.w    $4812, $A00, $F4F9
                dc.w    $481B, $A00, $F4EE
                dc.w    $4824, $500, $F8E7
                dc.w    $C828, $500, $F8DD
SharedCombatSpriteFrame50:  dc.w    $5809, $A00, $F409  ; DATA XREF: ROM:000E981C   o  ; was: word_E930E
                dc.w    $5812, $A00, $F4F9
                dc.w    $581B, $A00, $F4ED
                dc.w    $5824, $500, $F8E6
                dc.w    $D828, $500, $F8DD
SharedCombatSpriteFrame51:  dc.w    $5009, $A00, $F40A  ; DATA XREF: ROM:000E9820   o  ; was: word_E932C
                dc.w    $5012, $A00, $F4FA
                dc.w    $501B, $A00, $F4ED
                dc.w    $5024, $500, $F8E6
                dc.w    $D028, $500, $F8DC
SharedCombatSpriteFrame52:  dc.w    $4009, $A00, $F40A  ; DATA XREF: ROM:000E9824   o  ; was: word_E934A
                dc.w    $4012, $A00, $F4FA
                dc.w    $401B, $A00, $F4EE
                dc.w    $4024, $500, $F8E7
                dc.w    $C028, $500, $F8DC
SharedCombatSpriteFrame53:  dc.w    $48CB, $F00, $F0F0  ; DATA XREF: ROM:000E9838   o  ; was: word_E9368
                                        ; ROM:000E9858   o
                dc.w    $488B, $F00, $F0
                dc.w    $488B, $F00, $E0F0
                dc.w    $488B, $F00, $F000
                dc.w    $C88B, $F00, $F0E0
SharedCombatSpriteFrame54:  dc.w    $488B, $F00, $F0F0  ; DATA XREF: ROM:000E983C   o  ; was: word_E9386
                                        ; ROM:000E985C   o
                dc.w    $588B, $F00, $DCF0
                dc.w    $408B, $F00, $F0DC
                dc.w    $488B, $F00, $F004
                dc.w    $488B, $F00, $5F0
                dc.w    $489B, $F00, $E0
                dc.w    $409B, $F00, 0
                dc.w    $589B, $F00, $E0E0
                dc.w    $D09B, $F00, $E000
SharedCombatSpriteFrame55:  dc.w    $488B, $F00, $F0F0  ; DATA XREF: ROM:000E9840   o  ; was: word_E93BC
                                        ; ROM:000E9860   o
                dc.w    $409B, $F00, $F0D8
                dc.w    $589B, $F00, $D8F0
                dc.w    $489B, $F00, $F008
                dc.w    $489B, $F00, $8F0
                dc.w    $489B, $F00, $3DD
                dc.w    $409B, $F00, $303
                dc.w    $509B, $F00, $DD03
                dc.w    $D89B, $F00, $DDDD
SharedCombatSpriteFrame56:  dc.w    $C84C, $500, $F8F8  ; DATA XREF: ROM:SharedCombatSpriteAnimation18   o  ; was: word_E93F2
                                        ; ROM:SharedCombatSpriteAnimation19   o
SharedCombatSpriteFrame57:  dc.w    $C850, $500, $F8F8  ; DATA XREF: ROM:000E9700   o  ; was: word_E93F8
                                        ; ROM:000E9714   o
SharedCombatSpriteFrame58:  dc.w    $C854, 0, $FCFC     ; DATA XREF: ROM:000E9704   o  ; was: word_E93FE
                                        ; ROM:000E9718   o
SharedCombatSpriteFrame59:  dc.w    $C855, 0, $FCFC     ; DATA XREF: ROM:000E9708   o  ; was: word_E9404
                                        ; ROM:000E970C   o
SharedCombatSpriteFrame60:  dc.w    $489B, $F00, $F0F0  ; DATA XREF: ROM:000E9844   o  ; was: word_E940A
                                        ; ROM:000E9864   o
                dc.w    $58AB, $F00, $D6F0
                dc.w    $40AB, $F00, $F00A
                dc.w    $48AB, $F00, $AF0
                dc.w    $48AB, $F00, $F0D6
                dc.w    $58AB, $F00, $DB05
                dc.w    $40AB, $F00, $5DB
                dc.w    $48AB, $F00, $505
                dc.w    $D0AB, $F00, $DBDB
SharedCombatSpriteFrame61:  dc.w    $48AB, $F00, $F0F0  ; DATA XREF: ROM:000E9848   o  ; was: word_E9440
                                        ; ROM:000E9868   o
                dc.w    $40BB, $F00, $F00C
                dc.w    $48BB, $F00, $CF0
                dc.w    $48BB, $F00, $F0D4
                dc.w    $58BB, $F00, $D4F0
                dc.w    $48BB, $F00, $DBDB
                dc.w    $40BB, $F00, $DB05
                dc.w    $58BB, $F00, $5DB
                dc.w    $D0BB, $F00, $505
SharedCombatSpriteFrame62:  dc.w    $48CB, $F00, $F0F0  ; DATA XREF: ROM:000E9878   o  ; was: word_E9476
                                        ; ROM:000E9898   o
                dc.w    $588B, $F00, $E2F0
                dc.w    $588B, $F00, $F0E4
                dc.w    $D08B, $F00, $F0FC
SharedCombatSpriteFrame63:  dc.w    $48CB, $F00, $F0F0  ; DATA XREF: ROM:000E987C   o  ; was: word_E948E
                                        ; ROM:000E989C   o
                dc.w    $588B, $F00, $DEF0
                dc.w    $588B, $F00, $F0DE
                dc.w    $D08B, $F00, $F002
SharedCombatSpriteFrame64:  dc.w    $588B, $F00, $F0F0  ; DATA XREF: ROM:000E9880   o  ; was: word_E94A6
                                        ; ROM:000E98A0   o
                dc.w    $589B, $F00, $F0D9
                dc.w    $509B, $F00, $F007
                dc.w    $509B, $F00, $DDE3
                dc.w    $D89B, $F00, $DDFD
SharedCombatSpriteFrame65:  dc.w    $589B, $F00, $F0F0  ; DATA XREF: ROM:000E9884   o  ; was: word_E94C4
                                        ; ROM:000E98A4   o
                dc.w    $58AB, $F00, $F0D2
                dc.w    $50AB, $F00, $F00E
                dc.w    $58AB, $F00, $D8E0
                dc.w    $D0AB, $F00, $D800
SharedCombatSpriteFrame66:  dc.w    $58AB, $F00, $F0F0  ; DATA XREF: ROM:000E9888   o  ; was: word_E94E2
                                        ; ROM:000E98A8   o
                dc.w    $58BB, $F00, $F00F
                dc.w    $50BB, $F00, $F0D1
                dc.w    $58BB, $F00, $D5DF
                dc.w    $D0BB, $F00, $D501
SharedCombatSpriteFrame67:  dc.w    $C878, 0, $FCFC     ; DATA XREF: ROM:SharedCombatSpriteAnimation22   o  ; was: word_E9500
SharedCombatSpriteFrame68:  dc.w    $4874, 0, $F8F8     ; DATA XREF: ROM:000E9764   o  ; was: word_E9506
                                        ; ROM:000E976C   o
                dc.w    $C878, 0, $FCFC
                dc.w    $C874, 0, $F8F8
SharedCombatSpriteFrame69:  dc.w    $4872, 0, $F8F8     ; DATA XREF: ROM:000E9768   o  ; was: word_E9518
                dc.w    $C878, 0, $FCFC
                dc.w    $C872, 0, $F8F8
SharedCombatSpriteFrame70:  dc.w    $C8DD, $200, $F4FC  ; DATA XREF: ROM:0003081C   o  ; was: word_E952A
                                        ; ROM:0003082C   o
SharedCombatSpriteFrame71:  dc.w    $C8E0, $800, $FCF4  ; DATA XREF: ROM:off_30814   o  ; was: word_E9530
                                        ; ROM:00030824   o
SharedCombatSpriteFrame72:  dc.w    $C8E3, $A00, $F4F4  ; DATA XREF: ROM:00030818   o  ; was: word_E9536
                                        ; ROM:00030820   o
; ---------------------------------------------------------------------------
; Anim_ResolveTimedMappingFrame reads each stream as frame-relative offsets paired with
; duration or control words, then passes the resolved frame to Sprite_RenderMapping
SharedCombatSpriteAnimation00:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: ShipPiece_UpdateCountdown+20   o  ; was: off_E953C
                                        ; ROM:Boss_ZLeoParticleSpritePointers   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame02-*
                dc.w    4
                dc.w    SharedCombatSpriteFrame03-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame04-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame05-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame05-*
                dc.w    $FF
SharedCombatSpriteAnimation01:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: Player_SpawnTripleShot:Player_SpawnTripleShot_Loop   o  ; was: off_E9560
                                        ; sub_17678:Player_SpawnRadialShot_Loop   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame02-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame03-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame04-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame05-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame05-*
                dc.w    $FF
SharedCombatSpriteAnimation02:  dc.w    SharedCombatSpriteFrame07-*  ; DATA XREF: Effect_InitPlayerMotionProjectile+40   o  ; was: off_E9584
                                        ; ROM:00022564   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame02-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame03-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame04-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame05-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame05-*
                dc.w    $FF
SharedCombatSpriteAnimation03:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: ROM:00022568   o  ; was: off_E95A4
                                        ; ROM:0002256C   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame21-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame22-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame23-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame24-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame25-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame25-*
                dc.w    $FF
SharedCombatSpriteAnimation04:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: Projectile_FallingSpawner+1C   o  ; was: off_E95C0
                                        ; ROM:00031E88   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame21-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame22-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame23-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame24-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame25-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame25-*
                dc.w    $FF
SharedCombatSpriteAnimation05:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: ROM:00022570   o  ; was: off_E95DC
                                        ; Enemy_SpawnQuadProjectiles+2   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame08-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame06-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame26-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame27-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame28-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame29-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame30-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame30-*
                dc.w    $FF
SharedCombatSpriteAnimation06:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: ROM:Projectile_AimedDelayedCollisionShotDescriptor   o  ; was: off_E9604
                                        ; ROM:Projectile_FixedAngleDelayedCollisionShotDescriptor   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame08-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame06-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame26-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame27-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame28-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame29-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame30-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame30-*
                dc.w    $FF
SharedCombatSpriteAnimation07:  dc.w    SharedCombatSpriteFrame31-*  ; DATA XREF: Boss_WolfGaropaSpawnOrbExplosion+A   o  ; was: off_E962C
                                        ; ROM:000E9634   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame32-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation07-*
                dc.w    0
SharedCombatSpriteAnimation08:  dc.w    SharedCombatSpriteFrame33-*  ; DATA XREF: Projectile_UpdateTrailingArcHazardType1D0+16   o  ; was: off_E9638
                                        ; ROM:000E9648   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame35-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame34-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame35-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation08-*
                dc.w    0
SharedCombatSpriteAnimation09:  dc.w    SharedCombatSpriteFrame31-*  ; DATA XREF: ROM:000E965C   o  ; was: off_E964C
                dc.w    1
                dc.w    SharedCombatSpriteFrame33-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame32-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame34-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation09-*
                dc.w    0
SharedCombatSpriteAnimation10:  dc.w    SharedCombatSpriteFrame35-*  ; DATA XREF: ROM:000E9668   o  ; was: off_E9660
                dc.w    1
                dc.w    SharedCombatSpriteFrame36-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation10-*
                dc.w    0
SharedCombatSpriteAnimation11:  dc.w    SharedCombatSpriteFrame35-*  ; DATA XREF: ROM:000E9674   o  ; was: off_E966C
                dc.w    1
                dc.w    SharedCombatSpriteFrame36-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation11-*
                dc.w    0
                dc.w    SharedCombatSpriteFrame36-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame35-*
                dc.w    $FF
SharedCombatSpriteAnimation12:  dc.w    SharedCombatSpriteFrame37-*  ; DATA XREF: Weapon_UpdateSeekingMissile+16   o  ; was: off_E9680
                                        ; Projectile_InitializeDifficultyScaledTwoSpeedShot+34   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame38-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation12-*
                dc.w    0
SharedCombatSpriteAnimation13:  dc.w    SharedCombatSpriteFrame37-*  ; DATA XREF: WeaponSelect_Initialize+54   o  ; was: off_E968C
                                        ; Projectile_SpawnFragmentCluster+10   o
                dc.w    2
                dc.w    SharedCombatSpriteFrame38-*
                dc.w    2
                dc.w    SharedCombatSpriteAnimation13-*
                dc.w    0
SharedCombatSpriteAnimation14:  dc.w    SharedCombatSpriteFrame37-*  ; DATA XREF: Weapon_SpawnHomingEffect+D8   o  ; was: off_E9698
                                        ; ROM:000E96A8   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame32-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame38-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame31-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation14-*
                dc.w    0
SharedCombatSpriteAnimation15:  dc.w    SharedCombatSpriteFrame37-*  ; DATA XREF: ROM:000E96B8   o  ; was: off_E96AC
                dc.w    1
                dc.w    SharedCombatSpriteFrame21-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame38-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation15-*
                dc.w    0
                dc.w    SharedCombatSpriteFrame39-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame39-*
                dc.w    6
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    6
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame39-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    $FF
SharedCombatSpriteAnimation16:  dc.w    SharedCombatSpriteFrame40-*  ; DATA XREF: ROM:Projectile_AimedDelayedCollisionShotDescriptor   o  ; was: off_E96E0
                                        ; ROM:Projectile_FixedAngleDelayedCollisionShotDescriptor   o
                dc.w    2
                dc.w    SharedCombatSpriteFrame42-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame41-*
                dc.w    2
                dc.w    SharedCombatSpriteAnimation16-*
                dc.w    0
SharedCombatSpriteAnimation17:  dc.w    SharedCombatSpriteFrame40-*  ; DATA XREF: ROM:000E96F8   o  ; was: off_E96F0
                dc.w    2
                dc.w    SharedCombatSpriteFrame41-*
                dc.w    2
                dc.w    SharedCombatSpriteAnimation17-*
                dc.w    0
SharedCombatSpriteAnimation18:  dc.w    SharedCombatSpriteFrame56-*  ; DATA XREF: Boss_ViblackSpawnWideDefeatParticle+2E   o  ; was: off_E96FC
                                        ; Boss_ViblackSpawnTransitionDebris+4E   o
                dc.w    3
                dc.w    SharedCombatSpriteFrame57-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame58-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    3
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
SharedCombatSpriteAnimation19:  dc.w    SharedCombatSpriteFrame56-*  ; DATA XREF: ROM:000546F2   o  ; was: off_E9710
                dc.w    5
                dc.w    SharedCombatSpriteFrame57-*
                dc.w    5
                dc.w    SharedCombatSpriteFrame58-*
                dc.w    5
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    5
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
SharedCombatSpriteAnimation20:  dc.w    SharedCombatSpriteFrame56-*  ; DATA XREF: ROM:000546FA   o  ; was: off_E9724
                dc.w    1
                dc.w    SharedCombatSpriteFrame57-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame58-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
SharedCombatSpriteAnimation21:  dc.w    SharedCombatSpriteFrame06-*  ; DATA XREF: Effect_SpawnRandomDebris+46   o  ; was: off_E9738
                dc.w    1
                dc.w    SharedCombatSpriteFrame56-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame57-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame58-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame42-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame41-*
                dc.w    $FF
SharedCombatSpriteAnimation22:  dc.w    SharedCombatSpriteFrame67-*  ; DATA XREF: Object_UpdateProximityPickupEmitterType48+18   o  ; was: off_E975C
                                        ; Projectile_SpawnTrailingArcHazardType1D0+28   o
                dc.w    $20
                dc.w    SharedCombatSpriteFrame40-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame68-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame69-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame68-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation22-*
                dc.w    0
SharedCombatSpriteAnimation23:  dc.w    SharedCombatSpriteFrame09-*  ; DATA XREF: ROM:000E9784   o  ; was: off_E9774
                dc.w    1
                dc.w    SharedCombatSpriteFrame11-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame10-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame12-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation23-*
                dc.w    0
SharedCombatSpriteAnimation24:  dc.w    SharedCombatSpriteFrame09-*  ; DATA XREF: Projectile_UpdateTwoSpeedShotCollision+3E   o  ; was: off_E9788
                                        ; Projectile_UpdateType254TwoSpeedShotCollision+3E   o
                dc.w    2
                dc.w    SharedCombatSpriteFrame11-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame10-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame12-*
                dc.w    2
                dc.w    SharedCombatSpriteAnimation24-*
                dc.w    0
SharedCombatSpriteAnimation25:  dc.w    SharedCombatSpriteFrame18-*  ; DATA XREF: ROM:000E97B4   o  ; was: off_E979C
                dc.w    $18
                dc.w    SharedCombatSpriteFrame16-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame17-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame20-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame17-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame16-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation25-*
                dc.w    0
SharedCombatSpriteAnimation26:  dc.w    SharedCombatSpriteFrame19-*  ; DATA XREF: Pickup_InitializeMaxHealthUpgrade+A   o  ; was: off_E97B8
                                        ; ROM:000E97D0   o
                dc.w    $18
                dc.w    SharedCombatSpriteFrame43-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame44-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame45-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame44-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame43-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation26-*
                dc.w    0
SharedCombatSpriteAnimation27:  dc.w    SharedCombatSpriteFrame14-*  ; DATA XREF: ROM:0002BDAC   o  ; was: off_E97D4
                                        ; ROM:000E97DC   o
                dc.w    8
                dc.w    SharedCombatSpriteFrame56-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation27-*
                dc.w    0
SharedCombatSpriteAnimation28:  dc.w    SharedCombatSpriteFrame13-*  ; DATA XREF: ROM:Pickup_SpriteMappings   o  ; was: off_E97E0
                                        ; ROM:000E97E8   o
                dc.w    8
                dc.w    SharedCombatSpriteFrame15-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation28-*
                dc.w    0
SharedCombatSpriteAnimation29:  dc.w    SharedCombatSpriteFrame48-*  ; DATA XREF: ROM:000E97FC   o  ; was: off_E97EC
                dc.w    1
                dc.w    SharedCombatSpriteFrame47-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame46-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame37-*
                dc.w    5
                dc.w    SharedCombatSpriteAnimation29-*
                dc.w    0
Player_CounterForceEffectAnimation: dc.w    SharedCombatSpriteFrame40-*  ; DATA XREF: Player_CreateCounterForceEffect+2C   o  ; was: off_E9800
                dc.w    1
                dc.w    SharedCombatSpriteFrame06-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    $FF
SharedCombatSpriteAnimation31:  dc.w    SharedCombatSpriteFrame49-*  ; DATA XREF: ROM:000E9828   o  ; was: off_E9818
                dc.w    1
                dc.w    SharedCombatSpriteFrame50-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame51-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame52-*
                dc.w    1
                dc.w    SharedCombatSpriteAnimation31-*
                dc.w    0
                dc.w    SharedCombatSpriteFrame07-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame53-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame54-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame55-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame60-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame61-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
SharedCombatSpriteAnimation32:  dc.w    SharedCombatSpriteFrame01-*  ; DATA XREF: Projectile_FragmentConvertToImpact+1A   o  ; was: off_E9850
                                        ; Projectile_ZLeoLaserMain+120   o
                dc.w    1
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame53-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame54-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame55-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame60-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame61-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
SharedCombatSpriteAnimation33:  dc.w    SharedCombatSpriteFrame00-*  ; DATA XREF: Effect_ConvertCurrentToTypeC4Burst+2A   o  ; was: off_E9870
                dc.w    1
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame62-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame63-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame64-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame65-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame66-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
                dc.w    SharedCombatSpriteFrame00-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame01-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame62-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame63-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame64-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame65-*
                dc.w    2
                dc.w    SharedCombatSpriteFrame66-*
                dc.w    1
                dc.w    SharedCombatSpriteFrame59-*
                dc.w    $FF
