'' examples/manual/operator/new.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNew
'' --------

Type Rational
	As Integer	numerator, denominator
End Type

Scope

	' Create and initialize a Rational, and store it's address.
	Dim p As Rational Ptr = New Rational(3, 4)

	Print p->numerator & "/" & p->denominator

	' Destroy the rational and give its memory back to the system. 
	Delete p

End Scope

Scope

	' Allocate memory for 100 integers, store the address of the first one.
	Dim p As Integer Ptr = New Integer[100]

	' Assign some values to the integers in the array.
	For i As Integer = 0 To 99
		p[i] = i
	Next

	' Free the entire integer array.
	Delete[] p

End Scope
