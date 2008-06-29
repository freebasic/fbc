'' examples/manual/defines/fbsse.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbsse
'' --------

#ifdef __FB_SSE__
  ' ... instructions only for SSE ...
#else
  ' ... instructions not for SSE ...
#endif
