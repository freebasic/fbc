'' examples/manual/strings/cvi.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvi
'' --------

Dim i As Integer, s As String
s = "ABCD"
i = CVI(s)
Print Using "s = ""&"""; s
Print Using "i = _&H&"; Hex(i)
