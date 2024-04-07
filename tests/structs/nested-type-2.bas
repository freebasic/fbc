' TEST_MODE : COMPILE_ONLY_FAIL

'' don't allow assignment to typedef

Type UDT
    Dim As Integer I
    Type Int_ As Long
End Type

Dim As UDT u
u.Int_ = 0
