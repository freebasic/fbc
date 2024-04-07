' TEST_MODE : COMPILE_ONLY_OK

'' bug report: https://github.com/freebasic/fbc/issues/424

Declare Function TestConstZStringPtr( _
	ByVal key As Const ZString Ptr _
) As Const ZString Ptr

If TestConstZStringPtr(Str(265)) Then
End If

Dim Number As Integer = 0
Dim result As Const ZString Ptr = TestConstZStringPtr(Str(Number))

If TestConstZStringPtr(Str(Number)) Then
End If

