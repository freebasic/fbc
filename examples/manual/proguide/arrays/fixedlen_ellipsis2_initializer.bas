'' examples/manual/proguide/arrays/fixedlen_ellipsis2_initializer.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgFixLenArrays
'' --------

'' Declare (with two ellipsis) an array of 2 by 5 elements followed by an initializer
Dim array(1 To ..., 1 To ...) As Integer => {{1, 2, 3, 4, 5}, {1, 2, 3, 4, 5}}
		
