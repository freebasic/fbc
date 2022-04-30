'' examples/manual/system/command.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'COMMAND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommand
'' --------

Print "program launched via: " & Command(0)

Dim As Long i = 1
Do
	Dim As String arg = Command(i)
	If Len(arg) = 0 Then
		Exit Do
	End If

	Print "command line argument " & i & " = """ & arg & """"
	i += 1
Loop

If i = 1 Then
	Print "(no command line arguments)"
End If

Sleep
