'' examples/manual/strings/mkshort.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMkshort
'' --------

Dim a As Short, b As String
a = 4534
b = MKShort(a)
Print a, CVShort(b)
Sleep
