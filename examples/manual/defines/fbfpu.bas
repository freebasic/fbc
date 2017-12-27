'' examples/manual/defines/fbfpu.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbfpu
'' --------

#if __FB_FPU__ = "sse"
  ' ... instructions only for SSE ...
#else
  ' ... instructions not for SSE ...
#endif
