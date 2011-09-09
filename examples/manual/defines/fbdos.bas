'' examples/manual/defines/fbdos.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbdos
'' --------

#ifdef __FB_DOS__
  ' ... instructions only for DOS ...
  ' ... INT 0x31
#else
  ' ... instructions not for DOS ...
#endif 
