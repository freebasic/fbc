'' examples/manual/system/command.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCommand
'' --------

Print "program launched via: " & Command(0)

Dim As Integer i = 1
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
