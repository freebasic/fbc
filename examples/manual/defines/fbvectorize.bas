'' examples/manual/defines/fbvectorize.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_VECTORIZE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbvectorize
'' --------

#if __FB_VECTORIZE__ = 2
  ' ... instructions only for vectorization level 2...
#else
  ' ...
#endif
