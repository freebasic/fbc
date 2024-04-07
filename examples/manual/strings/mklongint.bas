'' examples/manual/strings/mklongint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MKLONGINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMklongint
'' --------

Dim a As LongInt, b As String
a = 4534
b = MKLongInt(a)
Print a, CVLongInt(b)
Sleep
