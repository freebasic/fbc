'' examples/manual/proguide/variadic_arguments/cva_.bas
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
	Dim s As String
	Dim args As Cva_List
	
	Cva_Start(args, count)
	
	For i As Integer = 1 To count
		If i < count Then
			s &= *Cva_Arg(args, ZString Ptr)
		Else
			s &= Cva_Arg(args, Double)
		End If
	Next
	
	Cva_End(args)
   
	Return s
End Function

Print concatenation(6, "Free", "BASIC", " ", "version", " ", 1.07)

Sleep

' Output: FreeBASIC version 1.07
		
