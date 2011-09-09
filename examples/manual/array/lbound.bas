'' examples/manual/array/lbound.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLbound
'' --------

Dim array(-10 To 10, 5 To 15, 1 To 2) As Integer

Print LBound(array) 'returns -10
Print LBound(array, 2) 'returns 5
Print LBound(array, 3) 'returns 1
