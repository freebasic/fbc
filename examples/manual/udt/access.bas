'' examples/manual/udt/access.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator . (Member access)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpMemberAccess
'' --------

Type T
	As Integer a, b
End Type

Dim x As T

'' Access the member 'a' of x.
x.a = 10

'' Access the member 'b' of x.
With x
	.b = 20
End With
