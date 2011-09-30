'' examples/manual/defines/fbminversion.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBMinVersion
'' --------

#if Not __FB_MIN_VERSION__(0, 18, 2)
 	#error fbc must be at least version 0.18.2 To compile This module
#endif
