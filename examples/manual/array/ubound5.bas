'' examples/manual/array/ubound5.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

Sub printArrayDimensions( array() As Integer )
	Print "dimensions: " & UBound( array, 0 )

	'' For each dimension...
	For d As Integer = LBound( array, 0 ) To UBound( array, 0 )
		Print "dimension " & d & ": " & LBound( array, d ) & " to " & UBound( array, d )
	Next
End Sub

Dim array() As Integer
printArrayDimensions( array() )

Print "---"

ReDim array(10 To 11, 20 To 22)
printArrayDimensions( array() )
