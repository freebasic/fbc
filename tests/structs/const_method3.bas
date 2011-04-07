' TEST_MODE : COMPILE_ONLY_FAIL

Type T
  value As Integer
  Declare Const Sub proc1()
  Declare Sub proc2()
  Declare Const Sub proc3()
  Declare Const Sub proc4()
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

