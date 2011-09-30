' TEST_MODE : COMPILE_ONLY_OK

Type T
  value As Integer
  Declare Const Sub proc1()
  Declare Const Sub proc2()
End Type

''
Sub T.proc1()

  proc2()

  this.proc2()

  With this
    .proc2()
  End With

End Sub

''
Sub T.proc2()
End Sub

