'' examples/manual/operator/new.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator New Expression'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNew
'' --------

Type Rational
	As Integer numerator, denominator
End Type

' Create and initialize a "rational" and store its address.
Dim p As Rational Ptr = New Rational(3, 4)

' Test if null return pointer
If (p = 0) Then
	Print "Error: unable to allocate memory"
Else
	Print p->numerator & "/" & p->denominator
	' Destroy the rational and give its memory back to the system.
	Delete p
End If

Sleep
