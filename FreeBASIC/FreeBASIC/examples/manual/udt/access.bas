'' examples/manual/udt/access.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpMemberAccess
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
