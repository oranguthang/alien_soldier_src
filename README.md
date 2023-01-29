# alien_soldier_src

Alien Soldier (J) source code (assemble with AS)

AS: http://john.ccac.rwth-aachen.de:8000/as/index.html

Inspired by https://github.com/lab313ru/quackshot_src/

## TODO:

1) fix several bugs when moving code:
   - $0-$8000 - worm before Bugmax is broken
   - $8000-$10000 - red screen before level after weapon select
   - $10000-$20000 - red screen before level after weapon select
   - $20000-$30000 - motorboat before Sharpsteel is broken
   - $30000-$40000 - mountain level before Destroyer MK-2 is broken
   - $50000-$60000 - Wolfgunblood Garopa is broken
   - $82324-$E8000 - PCM sounds are broken
   - $E8000-$180000 - graphics in levels are broken

2) create compressor for tiles (based on LZSS)
3) map data structures
4) find pointers to PCM sounds
5) find pointers to main character art
6) decompose data to separate files
