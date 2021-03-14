'' examples/manual/operator/new2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
