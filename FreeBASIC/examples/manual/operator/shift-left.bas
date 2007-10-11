'' examples/manual/operator/shift-left.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpShiftLeft
'' --------

'Double a number
Dim i As Integer

For i = 1 To 10
	Print 1 Shl i
Next i
Sleep
