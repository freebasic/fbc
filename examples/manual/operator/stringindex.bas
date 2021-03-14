'' examples/manual/operator/stringindex.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStringIndex
'' --------

Dim a As String = "Hello, world!"
Dim i As Integer

For i = 0 To Len(a) - 1
	Print Chr(a[i]) & " ";
Next i
Print
Print

For i = 1 To 4
	a[i] = a[i] - 32  ' converting lowercase alphabetic characters to uppercase
Next i
For i = 7 To 11
	a[i] = a[i] - 32  ' converting lowercase alphabetic characters to uppercase
Next i
Print a
	
