'' examples/manual/proguide/procs/passbyval.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Passing Arguments to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArguments
'' --------

Sub Procedure (ByVal param As Integer)
	param *= 2
	Print "The parameter 'param' = " & param
End Sub

Dim arg As Integer = 10
Print "The variable 'arg' before the call = " & arg
Procedure(arg)
Print "The variable 'arg' after the call = " & arg
