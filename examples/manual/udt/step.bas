'' examples/manual/udt/step.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Step (Iteration)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStep
'' --------

'' Example Type
Type T
  '' value is set by the constructor
  value As Double
  Declare Constructor( ByVal x As Double = 0 )

  Declare Operator For( ByRef stp As T )
  Declare Operator Step( ByRef stp As T )
  Declare Operator Next( ByRef cond As T, ByRef stp As T ) As Integer
End Type

Constructor T ( ByVal x As Double )
  Print "T iterator constructed with value " & x
  value = x
End Constructor

Operator T.for( ByRef stp As T )
End Operator

Operator T.step( ByRef stp As T )
  Print " incremented by " & stp.value & " in step."
  value += stp.value
End Operator

Operator T.next( ByRef cond As T, ByRef stp As T ) As Integer
  '' iterator's moving from a high value to a low value (step >= 0)
  If( stp.value < 0 ) Then
	Return( value >= cond.value )
  Else
  '' iterator's moving from a low value to a high value (step < 0)
	Return( value <= cond.value )
  End If
End Operator

'' Example Usage. It looks like we are working with numbers, but the iterators
'' have overloaded constructors. The 10, 1, and -1 are all of type T.
For i As T = 10 To 1 Step -1
  Print i.value;
Next i
	
