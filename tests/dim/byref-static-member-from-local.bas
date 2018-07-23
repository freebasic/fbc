' TEST_MODE : COMPILE_ONLY_FAIL

Type UDT1
  Dim As Integer I1
End Type

Type UDT2
  Dim As Integer I2
  Static Byref As UDT1 ru1
End Type

Dim As UDT1 u1

Dim Byref As UDT1 UDT2.ru1 = u1
