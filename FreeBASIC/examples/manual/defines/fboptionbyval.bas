'' examples/manual/defines/fboptionbyval.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionbyval
'' --------

#if( __FB_OPTION_BYVAL__ <> 0 )
  #error Option ByVal must not be used With This source
#endif
