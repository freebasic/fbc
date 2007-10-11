'' examples/manual/defines/fboptionescape.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionescape
'' --------

#if( __FB_OPTION_ESCAPE__ <> 0 )
  #error Option Escape must Not be used With This include file
#endif
