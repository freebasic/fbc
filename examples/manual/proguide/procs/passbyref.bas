'' examples/manual/proguide/procs/passbyref.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArguments
'' --------

Sub Procedure (ByRef param As Integer)
	param *= 2
	Print "The parameter 'param' = " & param
End Sub

Dim arg As Integer = 10
Print "The variable 'arg' before the call = " & arg
Procedure(arg)
Print "The variable 'arg' after the call = " & arg
