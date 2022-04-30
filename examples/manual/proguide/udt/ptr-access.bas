'' examples/manual/proguide/udt/ptr-access.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'User Defined Types'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgUDTs
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
