' TEST_MODE : COMPILE_ONLY_FAIL

Type T
  value As Integer
  Declare Const Sub proc1()
  Declare Sub proc2()
  Declare Const Sub proc3()
  Declare Const Sub proc4()
End Type

Sub T.proc4()

  '' This should fail since THIS is CONST

  Dim x As T
  this = x

End Sub

