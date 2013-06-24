'' examples/manual/strings/cvshort.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvshort
'' --------

Dim si As Short, s As String
s = "AB"
si = CVShort(s)
Print Using "s = ""&"""; s
Print Using "si = _&H&"; Hex(si)
