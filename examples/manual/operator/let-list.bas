'' examples/manual/operator/let-list.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpLetlist
'' --------

Type Vector3D
	x As Double
	y As Double
	z As Double
End Type

Dim a As Vector3D = ( 5, 7, 9 )

Dim x As Double, y As Double

'' Get the first two fields only
Let( x, y ) = a

Print "x = "; x
Print "y = "; y
