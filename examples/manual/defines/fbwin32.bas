'' examples/manual/defines/fbwin32.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_WIN32__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbwin32
'' --------

#ifdef __FB_WIN32__
  ' ... instructions only for Win ...
  ' ... GetProcAddress ...
#else
  ' ... instructions not for Win ...
#endif 
