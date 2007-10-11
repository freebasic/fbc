'' examples/manual/array/ubound.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

Dim array(-10 To 10, 5 To 15, 1 To 2) As Integer

Print UBound(array) 'returns 10
Print UBound(array, 2) 'returns 15
Print UBound(array, 3) 'returns 2
