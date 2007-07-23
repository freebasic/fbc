'' examples/manual/array/erase.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErase
'' --------

Dim MyArray1(1 To 10) As Integer
ReDim MyArray2(1 To 10) As Integer 

Erase MyArray1, MyArray2
