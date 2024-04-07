'' examples/manual/prepro/elseif.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#ELSEIF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpelseif
'' --------

#define WORDSIZE 16
#if (WORDSIZE = 16)
  ' Do some some 16 bit stuff
#elseif (WORDSIZE = 32)
  ' Do some some 32 bit stuff
#else
  #error WORDSIZE must be set To 16 Or 32
#endif
