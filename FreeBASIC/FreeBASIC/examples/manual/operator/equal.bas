'' examples/manual/operator/equal.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpEqual
'' --------

Dim i As Integer = 0    '' initialization: initialise i with a value of 0
i = 420                 '' assignment: assign to i the value of 420

If (i = 69) Then        '' equation: compare the equality of the value of i and 69
	Print "serious error: i should equal 420"
	End -1
End If
