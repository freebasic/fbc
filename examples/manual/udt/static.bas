'' examples/manual/udt/static.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STATIC (Member)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStaticMember
'' --------

'' Example showing how the actual procedure invoked by a member can be set at runtime.
'' using static member procedures.
Type _Object

  Enum handlertype
	ht_default
	ht_A
	ht_B
  End Enum

  Declare Constructor( ByVal ht As handlertype = ht_default)

  Declare Sub handler()

Private:
  Declare Static Sub handler_default( ByRef obj As _Object )
  Declare Static Sub handler_A( ByRef obj As _Object )
  Declare Static Sub handler_B( ByRef obj As _Object )
  handler_func As Sub( ByRef obj As _Object )

End Type

Constructor _Object( ByVal ht As handlertype )
  Select Case ht
  Case ht_A
	handler_func = @_Object.handler_A
  Case ht_B
	handler_func = @_Object.handler_B
  Case Else
	handler_func = @_Object.handler_default
  End Select
End Constructor

Sub _Object.handler()
  handler_func(This)
End Sub

Sub _Object.handler_default( ByRef obj As _Object )
  Print "Handling using default method"
End Sub

Sub _Object.handler_A( ByRef obj As _Object )
  Print "Handling using method A"
End Sub

Sub _Object.handler_B( ByRef obj As _Object )
  Print "Handling using method B"
End Sub

Dim objects(1 To 4) As _Object => _
  { _
	_Object.handlertype.ht_B, _
	_Object.handlertype.ht_default, _
	_Object.handlertype.ht_A _
  }
  '' 4th array item will be _Object.handlertype.ht_default

For i As Integer = 1 To 4
  Print i,
  objects(i).handler()
Next i
