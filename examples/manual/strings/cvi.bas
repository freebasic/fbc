'' examples/manual/strings/cvi.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVI'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvi
'' --------

Dim i As Integer, s As String
s = "ABCD"
i = CVI(s)
Print Using "s = ""&"""; s
Print Using "i = _&H&"; Hex(i)
