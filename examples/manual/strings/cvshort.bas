'' examples/manual/strings/cvshort.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVSHORT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvshort
'' --------

Dim si As Short, s As String
s = "AB"
si = CVShort(s)
Print Using "s = ""&"""; s
Print Using "si = _&H&"; Hex(si)
