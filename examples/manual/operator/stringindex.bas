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
