'' examples/manual/defines/fboptionexplicit.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OPTION_EXPLICIT__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionexplicit
'' --------

#if( __FB_OPTION_EXPLICIT__ = 0 )
  #error Option Explicit must used With This module
#endif
