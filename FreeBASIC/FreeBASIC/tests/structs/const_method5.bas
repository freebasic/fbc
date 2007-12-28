' TEST_MODE : COMPILE_ONLY_FAIL

Type T
  value As Integer
  Declare Const Sub proc1()
  Declare Sub proc2()
  Declare Const Sub proc3()
  Declare Const Sub proc4()
End Type

''
Sub T.proc3()

  value = 4

  this.value = 5

  With this
    .value = 6
  End With

End Sub

