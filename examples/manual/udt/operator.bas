'' examples/manual/udt/operator.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOperator
'' --------

Type Vector2D
  As Single x, y

  '' Return a string containing the vector data.
  Declare Operator Cast() As String
End Type

'' Allow two vectors to be able to be added together.
Declare Operator + ( ByRef lhs As Vector2D, ByRef rhs As Vector2D ) As Vector2D

Operator Vector2D.cast () As String
  Return "(" + Str(x) + ", " + Str(y) + ")"
End Operator

Operator + ( ByRef lhs As Vector2D, ByRef rhs As Vector2D ) As Vector2D
  Return Type<Vector2D>( lhs.x + rhs.x, lhs.y + rhs.y )
End Operator

Dim a As Vector2D = Type<Vector2D>( 1.2, 3.4 )
Dim b As Vector2D = Type<Vector2D>( 8.9, 6.7 )

Print "a = "; a
Print "b = "; b
Print "a + b = "; a + b
