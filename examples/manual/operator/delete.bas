'' examples/manual/operator/delete.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Delete Statement'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpDelete
'' --------

Type Rational
	As Integer numerator, denominator
End Type

' Create and initialize a Rational, and store its address.
Dim p As Rational Ptr = New Rational(3, 4)

Print p->numerator & "/" & p->denominator

' Destroy the rational and give its memory back to the system. 
Delete p

' Set the pointer to null to guard against future accesses
p = 0
