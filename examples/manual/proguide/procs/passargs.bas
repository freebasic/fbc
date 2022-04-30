'' examples/manual/proguide/procs/passargs.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Passing Arguments to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArguments
'' --------

Sub Procedure (s As String, n As Integer)
	Print "The parameters have the values: " & s & " and " & n
End Sub

Procedure "abc", 123
