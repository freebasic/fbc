'' examples/manual/strings/mklongint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMklongint
'' --------

Dim a As LongInt, b As String
a = 4534
b = MKLongInt(a)
Print a, CVLongInt(b)
Sleep
