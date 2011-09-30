'' examples/manual/procs/sub-2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSub
'' --------

' The following demonstrates optional parameters.

Sub TestSub(P As String = "Default")
	Print P
End Sub

TestSub "Testing:"
TestSub
