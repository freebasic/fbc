'' examples/manual/defines/fboptionprivate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionprivate
'' --------

#if( __FB_OPTION_PRIVATE__ <> 0 )
  #error Option Private must Not be used With This module
#endif
