'' examples/manual/operator/shift-right.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Shr (Shift right)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpShiftRight
'' --------

'Halve a number
For i As Integer = 0 To 10
	
	Print 1000 Shr i, Bin(1000 Shr i, 16)
	
Next i
