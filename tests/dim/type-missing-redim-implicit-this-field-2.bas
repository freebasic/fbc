' TEST_MODE : COMPILE_ONLY_FAIL

'' Regression test for #643

Type my_UDT
  Declare Constructor (Byval high_bound As Ubyte = 255)
  array(255) As Integer
End Type
Constructor my_UDT (Byval high_bound As Ubyte = 255)
  Redim array(high_bound)
  For I As Integer = 0 To high_bound
    array(I) = I
  Next I
End Constructor

Dim test As my_UDT = my_UDT(10)
For K As Ubyte = 0 To 10
  Print test.array(K);
Next K
Print

Sleep
