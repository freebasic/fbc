'' examples/manual/proguide/variadic_arguments/va_3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variadic Arguments'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariadicArguments
'' --------

' Variadic sub:
'    The first (fixed) parameter is the type of the variable arguments (Integer Ptr or Double Ptr).
'    One terminal argument (added after the useful arguments) must be the null pointer.

Sub printNumericList cdecl (ByRef argtype As String, ...)
	Dim As Integer datatype = 0
	If UCase(argtype) = "INTEGER PTR" Then
		datatype = 1
		Print "List of integers : ";
	ElseIf UCase(argtype) = "DOUBLE PTR" Then
		datatype = 2
		Print "List of doubles : ";
	Else
		Print "Invalid argument type"
		Exit Sub
	End If
   
	Dim arg As Any Ptr
	Dim pn As Any Ptr
   
	arg = va_first()

	Do
		pn = va_arg(arg, Any Ptr)
		If pn = 0 Then Exit Do
		Print ,
		Select Case As Const datatype
		Case 1
			Print *CPtr(Integer Ptr, pn);
		Case 2
			Print *CPtr(Double Ptr, pn);
		End Select    
		arg = va_next(arg, Any Ptr)
	Loop
   
	Print
End Sub

printNumericList("Integer Ptr", @Type<Integer>(123), @Type<Integer>(456), @Type<Integer>(789), CPtr(Integer Ptr, 0))
printNumericList("Double Ptr", @Type<Double>(1.2), @Type<Double>(3.4), @Type<Double>(5.6), @Type<Double>(7.8), CPtr(Double Ptr, 0))

Sleep

' Output:
' List of integers :           123           456           789
' List of doubles :            1.2           3.4           5.6           7.8
			
