'' examples/manual/strings/mkd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMkd
'' --------

Dim n As Double, e As String
n = 1.2345
e = MKD(n)
Print n, CVD(e)
