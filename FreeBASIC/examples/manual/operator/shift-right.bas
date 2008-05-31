'' examples/manual/operator/shift-right.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpShiftRight
'' --------

'Halve a number
For i As Integer = 0 To 10
	
	Print 1000 Shr i, Bin(1000 Shr i, 16)
	
Next i
