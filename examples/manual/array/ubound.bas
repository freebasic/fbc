'' examples/manual/array/ubound.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UBOUND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

Dim array(-10 To 10, 5 To 15, 1 To 2) As Integer

Print UBound(array) 'returns 10
Print UBound(array, 2) 'returns 15
Print UBound(array, 3) 'returns 2
