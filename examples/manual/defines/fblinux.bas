'' examples/manual/defines/fblinux.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_LINUX__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfblinux
'' --------

#ifdef __FB_LINUX__
  ' ... instructions only for Linux ...
  ' ... #libpath "/usr/X11/lib" 
#else
  ' ... instructions not for Linux ...
#endif 
