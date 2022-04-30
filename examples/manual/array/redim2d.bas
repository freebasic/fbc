'' examples/manual/array/redim2d.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'REDIM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRedim
'' --------

'' Define a variable-length array
Dim array() As Integer

'' ReDim array to have 3*4 elements
ReDim array(1 To 3, 1 To 4)

Dim As Integer n = 1, i, j

Print "3 * 4:"
Print
For i = LBound(array, 1) To UBound(array, 1)
	For j = LBound(array, 2) To UBound(array, 2)
		array(i, j) = n
		Print Using "##  "; array(i, j);
		n += 1
	Next
	Print
Next
Print


'' ReDim Preserve array to have 4*4 elements, preserving the contents
'' (only the first upper bound should be changed)
ReDim Preserve array(1 To 4, 1 To 4)

Print "4 * 4:"
Print
For i = LBound(array, 1) To UBound(array, 1)
	For j = LBound(array, 2) To UBound(array, 2)
		Print Using "##  "; array(i, j);
	Next
	Print
Next
Print


'' ReDim Preserve array to have 2*4 elements, preserving but trancating the contents
'' (only the first upper bound should be changed)
ReDim Preserve array(1 To 2, 1 To 4)

Print "2 * 4:"
Print
For i = LBound(array, 1) To UBound(array, 1)
	For j = LBound(array, 2) To UBound(array, 2)
		Print Using "##  "; array(i, j);
	Next
	Print
Next
Print
