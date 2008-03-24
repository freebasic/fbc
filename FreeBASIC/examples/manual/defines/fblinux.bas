'' examples/manual/defines/fblinux.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfblinux
'' --------

#ifdef __FB_LINUX__
  ' ... instructions only for Linux ...
  ' ... #libpath "/usr/X11/lib" 
#else
  ' ... instructions not for Linux ...
#endif 
