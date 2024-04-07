'' examples/manual/operator/shift-left.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Shl (Shift left)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpShiftLeft
'' --------

'Double a number
For i As Integer = 0 To 10
	
	Print 5 Shl i, Bin(5 Shl i, 16)
	
Next i
