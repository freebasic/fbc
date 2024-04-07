'' examples/manual/defines/fboptionprivate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OPTION_PRIVATE__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionprivate
'' --------

#if( __FB_OPTION_PRIVATE__ <> 0 )
  #error Option Private must Not be used With This module
#endif
