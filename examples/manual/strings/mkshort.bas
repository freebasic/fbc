'' examples/manual/strings/mkshort.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MKSHORT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMkshort
'' --------

Dim a As Short, b As String
a = 4534
b = MKShort(a)
Print a, CVShort(b)
Sleep
