'' examples/manual/defines/fbwin32.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbwin32
'' --------

#ifdef __FB_WIN32__
  ' ... instructions only for Win32 ...
  ' ... GetProcAddress ...
#else
  ' ... instructions not for Win32 ...
#endif 
