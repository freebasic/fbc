'' examples/manual/prepro/if.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#IF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpif
'' --------

#define DEBUG_LEVEL 1
#if (DEBUG_LEVEL >= 2)
  ' This line is not compiled since the expression is False
  Print "Starting application"
#endif
