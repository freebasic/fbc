'' examples/manual/strings/instrrev2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInstrrev
'' --------

Dim test As String
Dim idx As Integer

test = "abababab"
idx = InStrRev(test, "b")

Do While idx > 0 'if not found loop will be skipped
	Print """b"" at " & idx
	idx = InStrRev(Test, "b", idx - 1)
Loop
