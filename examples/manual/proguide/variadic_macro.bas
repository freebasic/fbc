'' examples/manual/proguide/variadic_macro.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Macros'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMacros
'' --------

' macro with a variadic parameter which can contain several sub-parameters:
'   To distinguish between the different arguments passed by variadic_parameter,
'   you can first convert variadic_parameter to a string using the Operator # (Preprocessor Stringize),
'   then differentiate in this string (#variadic_parameter) each passed argument by locating the separators (usually a comma).

#macro average(result, arg...)
	Scope
		Dim As String s = #arg
		If s <> "" Then
			result = 0
			Dim As Integer n
			Do
				Dim As Integer k = InStr(1, s, ",")
				If k = 0 Then
					result += Val(s)
					result /= n + 1
					Exit Do
				End If
				result += Val(Left(s, k - 1))
				n += 1
				s = Mid(s, k + 1)
			Loop
		End If
	End Scope
#endmacro

Dim As Double result
average(result, 1, 2, 3, 4, 5, 6)
Print result

' Output : 3.5
		
