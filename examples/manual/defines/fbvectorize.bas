'' examples/manual/defines/fbvectorize.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbvectorize
'' --------

#if __FB_VECTORIZE__ = 2
  ' ... instructions only for vectorization level 2...
#else
  ' ...
#endif
