'' examples/manual/array/preserve.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPreserve
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
