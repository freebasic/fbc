'' examples/manual/operator/let-list.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator LET() (Assignment)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpLetlist
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
