'' examples/manual/udt/property.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'PROPERTY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgProperty
'' --------

Type Vector2D
  As Single x, y
  Declare Operator Cast() As String
  Declare Property Length() As Single
  Declare Property Length( ByVal new_length As Single )
End Type

Operator Vector2D.cast () As String
  Return "(" + Str(x) + ", " + Str(y) + ")"
End Operator

Property Vector2D.Length() As Single
  Length = Sqr( x * x + y * y )
End Property

Property Vector2D.Length( ByVal new_length As Single )
  Dim m As Single = Length
  If m <> 0 Then
	'' new vector = old / length * new_length
	x *= new_length / m
	y *= new_length / m
  End If
End Property

Dim a As Vector2D = ( 3, 4 )

Print "a = "; a
Print "a.length = "; a.length
Print

a.length = 10

Print "a = "; a
Print "a.length = "; a.length
