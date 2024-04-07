'' examples/manual/system/exec.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXEC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExec
'' --------

'A Windows based example but the same idea applies to Linux
Const exename = "NoSuchProgram.exe"
Const cmdline = "arg1 arg2 arg3"
Dim result As Long
result = Exec( exename, cmdline )
If result = -1 Then
	Print "Error running "; exename
Else
	Print "Exit code:"; result
End If
