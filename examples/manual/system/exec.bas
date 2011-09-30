'' examples/manual/system/exec.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExec
'' --------

'A Windows based example but the same idea applies to Linux
Const exename = "NoSuchProgram.exe"
Const cmdline = "arg1 arg2 arg3"
Dim result As Integer
result = Exec( exename, cmdline )
If result = -1 Then
	Print "Error running "; exename
Else
	Print "Exit code:"; result
End If
