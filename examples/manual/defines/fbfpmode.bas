'' examples/manual/defines/fbfpmode.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_FPMODE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbfpmode
'' --------

#if __FB_FPMODE__ = "fast"
  ' ... instructions for using fast-mode math ...
#else
  ' ... instructions for using normal math ...
#endif
