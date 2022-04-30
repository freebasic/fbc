'' examples/manual/defines/fboptionescape.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OPTION_ESCAPE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionescape
'' --------

#if( __FB_OPTION_ESCAPE__ <> 0 )
  #error Option Escape must Not be used With This include file
#endif
