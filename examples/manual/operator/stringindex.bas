'' examples/manual/operator/stringindex.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator [] (String index)'
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
	
