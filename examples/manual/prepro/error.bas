'' examples/manual/prepro/error.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPperror
'' --------

#define c 1

#if c = 1
  #error Bad value of c 
#endif
