' TEST_MODE : COMPILE_ONLY_FAIL

Sub funk( a() As Double )
        ? a(0)
End Sub

Dim As Integer a(9)       
a(0) = 3       
funk( a() )   
sleep