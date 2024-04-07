'' examples/manual/strings/mks.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'MKS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMks
'' --------

Dim n As Single, e As String
n = 1.2345
e = MKS(n)
Print n, CVS(e)
