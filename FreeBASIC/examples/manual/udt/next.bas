'' examples/manual/udt/next.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNext
'' --------

'' Example Type

Type T

  value As Double

  Declare Constructor( ByVal x As Double = 0 )

  Declare Operator += ( ByVal x As Double )

  Declare Operator For( ByRef stp As T )
  Declare Operator Step( ByRef stp As T )
  Declare Operator Next( ByRef cond As T, ByRef stp As T ) As Integer

  Declare Operator Cast() As String

End Type

Constructor T ( ByVal x As Double )
  value = x
End Constructor

Operator <= ( ByRef lhs As T, ByRef rhs As T ) As Integer
  Operator = ( lhs.value <= rhs.value )
End Operator

Operator >= ( ByRef lhs As T, ByRef rhs As T ) As Integer
  Operator = ( lhs.value >= rhs.value )
End Operator

Operator T.+= ( ByVal x As Double )
  value +=  x
End Operator

Operator T.for( ByRef stp As T )
End Operator

Operator T.step( ByRef stp As T )
  This += stp.value
End Operator

Operator T.next( ByRef cond As T, ByRef stp As T ) As Integer
  If( stp.value < 0 ) Then
	Operator = ( This >= cond )
  Else
	Operator = ( This <= cond )
  End If
End Operator

Operator T.cast() As String
  Operator = Str( value )
End Operator

'' Example Usage

For i As T = 10 To 1 Step -1
  Print i
Next i
