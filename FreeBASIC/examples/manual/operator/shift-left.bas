'' examples/manual/operator/shift-left.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpShiftLeft
'' --------

'Double a number
For i As Integer = 0 To 10
	
	Print 5 Shl i, Bin(5 Shl i, 16)
	
Next i
