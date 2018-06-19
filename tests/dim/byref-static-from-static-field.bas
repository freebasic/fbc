' TEST_MODE : COMPILE_ONLY_FAIL

Type UDT
  Dim As Integer I = 123
End Type

Static As UDT u

Static Byref As Integer RI = u.I
Print RI
