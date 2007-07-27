'' examples/manual/udt/static.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgStaticMember
'' --------

'' Example showing how the actual procedure invoked by a member can be set at runtime.
'' using static member procedures.
Type Object

  Enum handlertype
	ht_default
	ht_A
	ht_B
  End Enum

  Declare Constructor( ByVal ht As handlertype = ht_default)

  Declare Sub handler()

Private:
  Declare Static Sub handler_default( ByRef obj As Object )
  Declare Static Sub handler_A( ByRef obj As Object )
  Declare Static Sub handler_B( ByRef obj As Object )
  handler_func As Sub( ByRef obj As Object )

End Type

Constructor Object( ByVal ht As handlertype )
  Select Case ht
  Case ht_A
	handler_func = @Object.handler_A
  Case ht_B
	handler_func = @Object.handler_B
  Case Else
	handler_func = @Object.handler_default
  End Select
End Constructor

Sub Object.handler()
  handler_func(This)
End Sub

Sub Object.handler_default( ByRef obj As Object )
  Print "Handling using default method"
End Sub

Sub Object.handler_A( ByRef obj As Object )
  Print "Handling using method A"
End Sub

Sub Object.handler_B( ByRef obj As Object )
  Print "Handling using method B"
End Sub

Dim objects(1 To 4) As Object => _
  { _
	Object.handlertype.ht_B, _
	Object.handlertype.ht_default, _
	Object.handlertype.ht_A _
  }
  '' 4th array item will be Object.handlertype.ht_default

For i As Integer = 1 To 4
  Print i,
  objects(i).handler()
Next i
