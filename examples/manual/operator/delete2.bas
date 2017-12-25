'' examples/manual/operator/delete2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpDelete
'' --------

' Allocate memory for 100 integers, store the address of the first one.
Dim p As Integer Ptr = New Integer[100]

' Assign some values to the integers in the array.
For i As Integer = 0 To 99
	p[i] = i
Next

' Free the entire integer array.
Delete[] p

' Set the pointer to null to guard against future accesses
p = 0
