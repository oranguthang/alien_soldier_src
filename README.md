# alien_soldier_src

Alien Soldier (J) source code (assemble with AS)

AS: http://john.ccac.rwth-aachen.de:8000/as/index.html

Inspired by https://github.com/lab313ru/quackshot_src/

## TODO:

1) fix several bugs when moving code:
   - $3C000-$40000 - Gusthead is broken
   - $50000-$58000 - Wolfgunblood Garopa is broken
   - $82324-$E8000 - PCM sounds are broken
   - $E8000-$121932 - graphics in levels are broken

2) create compressor for tiles (based on LZSS)
3) map data structures
4) decompose data to separate files
5) create data folder for mappings