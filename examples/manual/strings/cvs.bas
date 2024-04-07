'' examples/manual/strings/cvs.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvs
'' --------

Dim f As Single, i As Integer
f = 1.125
i = CVI(f)

Print Using "i = _&H&"; Hex(i)
Print Using "cvs(i) = &"; CVS(i)
