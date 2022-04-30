'' examples/manual/system/chain.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CHAIN'
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
