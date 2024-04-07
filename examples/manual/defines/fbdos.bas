'' examples/manual/defines/fbdos.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_DOS__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbdos
'' --------

#ifdef __FB_DOS__
  ' ... instructions only for DOS ...
  ' ... INT 0x31
#else
  ' ... instructions not for DOS ...
#endif 
