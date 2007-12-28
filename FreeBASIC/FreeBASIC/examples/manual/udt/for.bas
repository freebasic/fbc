'' examples/manual/udt/for.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpFor
'' --------

'' Example Type

Type T

  value As Double

  Declare Constructor( ByVal x As Double = 0 )

  Declare Operator += ( ByVal x As Double )

  Declare Operator For()
  Declare Operator Step()
  Declare Operator Next( ByRef cond As T ) As Integer

  Declare Operator Cast() As String

End Type

Constructor T ( ByVal x As Double )
  value = x
End Constructor

Operator <= ( ByRef lhs As T, ByRef rhs As T ) As Integer
  Operator = ( lhs.value <= rhs.value )
End Operator

Operator T.+= ( ByVal x As Double )
  value +=  x
End Operator

Operator T.for()
End Operator

Operator T.step()
  This += 1
End Operator

Operator T.next( ByRef cond As T ) As Integer
  Operator = ( This <= cond )
End Operator

Operator T.cast() As String
  Operator = Str( value )
End Operator

'' Example Usage

For i As T = 1 To 10
  Print i
Next i
