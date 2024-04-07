'' examples/manual/module/namespace.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'NAMESPACE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgNamespace
'' --------

Namespace Forms
	Type Point '' A 2D point
		As Integer x
		As Integer y
	End Type
	'' Since we are inside of the namespace, Point resolves to Forms.Point.
	Sub AdjustPoint( ByRef pt As Point, ByVal newx As Integer, ByVal newy As Integer )
		pt.x = newx
		pt.y = newy
	End Sub
End Namespace

Type Point '' A 3D point
	As Integer x
	As Integer y
	As Integer z
End Type

Sub AdjustPoint( ByRef pt As Point, ByVal newx As Integer, ByVal newy As Integer, ByVal newz As Integer )
	pt.x = newx
	pt.y = newy
	pt.z = newz
End Sub

Dim pt1 As Point
AdjustPoint( pt1, 1, 1, 1 )
Dim pt2 As Forms.Point
Forms.AdjustPoint( pt2, 1, 1 )
