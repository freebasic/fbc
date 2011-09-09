'' examples/manual/defines/fboptionexplicit.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionexplicit
'' --------

#if( __FB_OPTION_EXPLICIT__ = 0 )
  #error Option Explicit must used With This module
#endif
