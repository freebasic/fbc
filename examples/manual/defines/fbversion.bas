'' examples/manual/defines/fbversion.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbversion
'' --------

#if __FB_VERSION__ < "0.18" 
#error  Please compile With FB version 0.18 Or above 
#endif
