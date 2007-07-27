'' examples/manual/prepro/if.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpif
'' --------

#define DEBUG_LEVEL 1
#if (DEBUG_LEVEL >= 2)
  ' This line is not compiled since the expression is False
  Print "Starting application"
#endif
