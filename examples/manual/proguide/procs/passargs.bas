'' examples/manual/proguide/procs/passargs.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArguments
'' --------

Sub Procedure (s As String, n As Integer)
	Print "The parameters have the values: " & s & " and " & n
End Sub

Procedure "abc", 123
