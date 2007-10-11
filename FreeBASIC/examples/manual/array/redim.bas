'' examples/manual/array/redim.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRedim
'' --------

'' Define a variable-length array with 5 elements
''
ReDim array(1 To 5) As Integer

For index As Integer = LBound(array) To UBound(array)
	array(index) = index
Next

'' Resize a variable-length array with 10 elements
''
ReDim Preserve array(9) As Integer

Print "index", "value"
For index As Integer = LBound(array) To UBound(array)
	Print index, array(index)
Next
