'' examples/manual/strings/cvs.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvs
'' --------

Dim f As Single, i As Integer
f = 1.125
i = CVI(f)

Print Using "i = _&H&"; Hex(i)
Print Using "cvs(i) = &"; CVS(i)
