'' examples/manual/prepro/macro4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#MACRO...#ENDMACRO'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpmacro
'' --------

' macro with a variadic parameter which can contain several sub-parameters:
'   To distinguish between the different arguments passed by variadic_parameter,
'   you can first convert variadic_parameter to a string using the Operator # (Preprocessor Stringize),
'   then differentiate in this string (#variadic_parameter) each passed argument by locating the separators (usually a comma).

#macro test2( arg1, arg2... )
	Print "'" & Trim(#arg1) & "'"
	Scope
		Dim As String s = Trim(#arg2)
		If s <> "" Then
			Do
				Dim As Integer k = InStr(1, s, ",")
				If k = 0 Then
					Print "'" & s & "'"
					Exit Do
				End If
				Print "'" & Left(s, k - 1) & "'"
				s = Trim(Mid(s, k+1))
			Loop
		End If
	End Scope
#endmacro

test2( 5 )
Print "----"
test2( 5,6, 7, , 9, 10, ,,13, 14 )

/' Output :
'5'
----
'5'
'6'
'7'
''
'9'
'10'
''
''
'13'
'14'
'/
	
