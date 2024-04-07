'' examples/manual/proguide/variadic_arguments/va_.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variadic Arguments'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariadicArguments
'' --------

' Variadic function:
'    The first(fixed) parameter provides the number of elements.
'    The variable arguments are all strings except the last one which must be a float.
'    The user's string arguments are in fact passed under the hood through zstring pointers.

Function concatenation cdecl (ByVal count As Integer, ...) As String
	Dim arg As Any Ptr
	Dim s As String
   
	arg = va_first()

	For i As Integer = 1 To count
		If i < count Then
			s &= *va_arg(arg, ZString Ptr)
			arg = va_next(arg, ZString Ptr)
		Else
			s &= va_arg(arg, Double)
		End If
	Next
   
	Return s
End Function

Print concatenation(6, "Free", "BASIC", " ", "version", " ", 0.13)

Sleep

' Output: FreeBASIC version 0.13
		
