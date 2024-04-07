'' examples/manual/defines/fbjs.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_JS__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbjs
'' --------

#ifdef __FB_JS__
  '...instructions only for emscripten target...
#else
  '...instructions not for emscripten target...
#endif 
