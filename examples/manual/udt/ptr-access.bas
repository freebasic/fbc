'' examples/manual/udt/ptr-access.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator -> (Pointer to member access)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPtrMemberAccess
'' --------

Type rect
	x As Integer
	y As Integer
End Type

Dim r As rect
Dim rp As rect Pointer = @r

rp->x = 4
rp->y = 2

Print "x = " & rp->x & ", y = " & rp->y
Sleep
