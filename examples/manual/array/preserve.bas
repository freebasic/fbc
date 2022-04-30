'' examples/manual/array/preserve.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PRESERVE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPreserve
'' --------

ReDim array(1 To 3) As Integer
Dim i As Integer

array(1) = 10
array(2) = 5
array(3) = 8

ReDim Preserve array(1 To 10)

For i = 1 To 10
	Print "array("; i; ") = "; array(i)
Next
