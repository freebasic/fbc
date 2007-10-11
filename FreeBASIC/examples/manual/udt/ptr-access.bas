'' examples/manual/udt/ptr-access.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPtrMemberAccess
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
