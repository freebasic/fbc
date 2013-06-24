'' examples/manual/operator/delete.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpDelete
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
