'' examples/manual/strings/cvl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvl
'' --------

Dim l As Long, s As String
s = "ABCD"
l = CVL(s)
Print Using "s = ""&"""; s
Print Using "l = &"; l
