'' examples/manual/system/chain.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChain
'' --------

#ifdef __FB_LINUX__
	Dim As String program = "./program"
#else
	Dim As String program = "program.exe"
#endif

Print "Running " & program & "..."
If (Chain(program) <> 0) Then
	Print program & " not found!"
End If
