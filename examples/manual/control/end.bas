'' examples/manual/control/end.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'END (Statement)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEnd
'' --------

'' This program requests a string from the user, and returns an error
'' code to the OS if the string was empty

Function main() As Integer

	'' assign input to text string
	Dim As String text
	Line Input "Enter some text ( try ""abc"" ): " , text

	'' If string is empty, print an error message and
	'' return error code 1 (failure)
	If( text = "" ) Then
		Print "ERROR: string was empty"
		Return 1
	End If

	'' string is not empty, so print the string and
	'' return error code 0 (success)
	Print "You entered: " & text
	Return 0

End Function

'' call main() and return the error code to the OS
End main()
