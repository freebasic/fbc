'' examples/manual/operator/shl-assign.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineShiftLeft
'' --------

Dim i As Integer
i = &b00000011   '' = 3
i Shl= 3         '' = i*2^3
'' Result: 11000          24            24
Print Bin(i), i, 3*2^3
Sleep
