'' examples/manual/strings/mkd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MKD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMkd
'' --------

Dim n As Double, e As String
n = 1.2345
e = MKD(n)
Print n, CVD(e)
