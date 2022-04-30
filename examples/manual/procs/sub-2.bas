'' examples/manual/procs/sub-2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SUB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSub
'' --------

' The following demonstrates optional parameters.

Sub TestSub(P As String = "Default")
	Print P
End Sub

TestSub "Testing:"
TestSub
