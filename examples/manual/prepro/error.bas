'' examples/manual/prepro/error.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#ERROR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPperror
'' --------

#define c 1

#if c = 1
  #error Bad value of c 
#endif
