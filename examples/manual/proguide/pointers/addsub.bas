'' examples/manual/proguide/pointers/addsub.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPtrArithmetic
'' --------

Dim p As Integer Ptr = New Integer[2]

*p = 1
*(p + 1) = 2
