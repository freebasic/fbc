'' examples/manual/defines/fbfpu.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_FPU__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbfpu
'' --------

#if __FB_FPU__ = "sse"
  ' ... instructions only for SSE ...
#else
  ' ... instructions not for SSE ...
#endif
