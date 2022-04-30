'' examples/manual/udt/operator1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPERATOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOperator
'' --------

'' operator1.bas

Type Vector2D
  As Single x, y

  '' Return a string containing the vector data.
  Declare Operator Cast() As String

  '' Multiply the vector by a scalar.
  Declare Operator *= ( ByVal rhs As Single )
End Type

'' Allow two vectors to be able to be added together.
Declare Operator + ( ByRef lhs As Vector2D, ByRef rhs As Vector2D ) As Vector2D

'' Return the modulus (single) of the vector using the overloaded operator abs().
Declare Operator Abs (  ByRef rhs As Vector2D ) As Single

Operator Vector2D.cast () As String
  Return "(" + Str(x) + ", " + Str(y) + ")"
End Operator

Operator Vector2D.*= ( ByVal rhs As Single )
  This.x *= rhs
  This.y *= rhs
End Operator

Operator + ( ByRef lhs As Vector2D, ByRef rhs As Vector2D ) As Vector2D
  Return Type<Vector2D>( lhs.x + rhs.x, lhs.y + rhs.y )
End Operator

Operator Abs ( ByRef rhs As Vector2D ) As Single
  Return Sqr( rhs.x * rhs.x + rhs.y * rhs.y )
End Operator

Dim a As Vector2D = Type<Vector2D>( 1.2, 3.4 )
Dim b As Vector2D = Type<Vector2D>( 8.9, 6.7 )
Dim c As Vector2D = Type<Vector2D>( 4.3, 5.6 )

Print "a = "; a, "abs(a) ="; Abs( a )
Print "b = "; b, "abs(b) ="; Abs( b )
Print "a + b = "; a + b, "abs(a+b) ="; Abs( a + b )
Print "c = "; c, "abs(c) ="; Abs( c )
Print "'c *= 3'"
c *= 3
Print "c = "; c, "abs(c) ="; Abs( c )
