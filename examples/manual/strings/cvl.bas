'' examples/manual/strings/cvl.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvl
'' --------

Dim l As Long, s As String
s = "ABCD"
l = CVL(s)
Print Using "s = ""&"""; s
Print Using "l = &"; l
