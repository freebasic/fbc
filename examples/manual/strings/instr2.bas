'' examples/manual/strings/instr2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INSTR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInstr
'' --------

Dim test As String
Dim idx As Integer

test = "abababab"
idx = InStr(test, "b")

Do While idx > 0 'if not found loop will be skipped
	Print """b"" at " & idx
	idx = InStr(idx + 1, Test, "b")
Loop
