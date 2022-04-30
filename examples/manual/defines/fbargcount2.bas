'' examples/manual/defines/fbargcount2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARG_COUNT__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbargcount
'' --------

' macro with a variadic parameter which can contain several sub-parameters:
'   To distinguish between the different arguments passed by a variadic_parameter,
'   you can first convert the variadic_parameter to a string using the Operator # (Preprocessor Stringize),
'   then differentiate in this string (#variadic_parameter) each passed argument by locating the separators (usually a comma)
'   in a [For...Next] loop based on the number of arguments (__FB_ARG_COUNT__) passed to the macro.

#macro average(result, arg...)
	Scope
		Dim As String s = #arg
		If s <> "" Then
			result = 0
			For I As Integer = 1 To __FB_ARG_COUNT__( arg ) - 1
				Dim As Integer k = InStr(1, s, ",")
				result += Val(Left(s, k - 1))
				s = Mid(s, k + 1)
			Next I
			result += Val(s)
			result /= __FB_ARG_COUNT__( arg )
		End If
	End Scope
#endmacro

Dim As Double result
average(result, 1, 2, 3, 4, 5, 6)
Print result

Sleep

/' Output :
 3.5
'/
	
