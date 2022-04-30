'' examples/manual/operator/new2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator New Expression'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNew
'' --------

' Allocate memory for 100 integers and store the address of the first one.
Dim p As Integer Ptr = New Integer[100]

' Test if null return pointer
If (p = 0) Then
	Print "Error: unable to allocate memory"
Else
	' Assign some values to the integers in the array.
	For i As Integer = 0 To 99
		p[i] = i
	Next
	' Free the entire integer array.
	Delete[] p
End If

Print "Done."
Sleep
