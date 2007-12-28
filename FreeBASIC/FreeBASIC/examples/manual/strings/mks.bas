'' examples/manual/strings/mks.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMks
'' --------

Dim n As Single, e As String
n = 1.2345
e = MKS(n)
Print n, CVS(e)
