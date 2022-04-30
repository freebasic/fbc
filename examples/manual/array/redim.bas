'' examples/manual/array/redim.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'REDIM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRedim
'' --------

'' Define a variable-length array with 5 elements
ReDim array(0 To 4) As Integer

For index As Integer = LBound(array) To UBound(array)
	array(index) = index
Next

'' Resize a variable-length array with 10 elements 
'' (the lower bound should be kept the same)
ReDim Preserve array(0 To 9)

Print "index", "value"
For index As Integer = LBound(array) To UBound(array)
	Print index, array(index)
Next
