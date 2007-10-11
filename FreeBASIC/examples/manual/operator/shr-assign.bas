'' examples/manual/operator/shr-assign.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineShiftRight
'' --------

Dim i As Integer
i = &b00011000   '' = 24
i Shr= 3         '' = i\2^3
'' Result: 11          3            3
Print Bin(i), i, 24\2^3
Sleep
