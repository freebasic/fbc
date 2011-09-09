'' examples/manual/defines/fbfpmode.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbfpmode
'' --------

#if __FB_FPMODE__ = "fast"
  ' ... instructions for using fast-mode math ...
#else
  ' ... instructions for using normal math ...
#endif
