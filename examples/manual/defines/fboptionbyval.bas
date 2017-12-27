'' examples/manual/defines/fboptionbyval.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionbyval
'' --------

#if( __FB_OPTION_BYVAL__ <> 0 )
  #error Option ByVal must Not be used With This source
#endif
