'' examples/manual/defines/fblang.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_LANG__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfblang
'' --------

'' Set option explicit always on

#ifdef __FB_LANG__
  #if __FB_LANG__ <> "fb"
	Option Explicit
  #endif
#else
  '' Older version - before lang fb
  Option Explicit
#endif
