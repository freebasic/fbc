' TEST_MODE : COMPILE_ONLY_FAIL

'' don't allow assignment to forward ref

Type UDT
    Dim As Integer I
	type A_ as A
End Type

Dim As UDT u
u.A = 0
