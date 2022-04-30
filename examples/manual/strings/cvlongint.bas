'' examples/manual/strings/cvlongint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVLONGINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvlongint
'' --------

Dim ll As LongInt, s As String
s = "ABCDEFGH"
ll = CVLongInt(s)
Print Using "s = ""&"""; s
Print Using "ll = _&H&"; Hex(ll)
