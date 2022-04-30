'' examples/manual/array/lbound.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LBOUND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLbound
'' --------

Dim array(-10 To 10, 5 To 15, 1 To 2) As Integer

Print LBound(array) 'returns -10
Print LBound(array, 2) 'returns 5
Print LBound(array, 3) 'returns 1
