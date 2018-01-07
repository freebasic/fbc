'' examples/manual/strings/cvlongint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvlongint
'' --------

Dim ll As LongInt, s As String
s = "ABCDEFGH"
ll = CVLongInt(s)
Print Using "s = ""&"""; s
Print Using "ll = _&H&"; Hex(ll)
