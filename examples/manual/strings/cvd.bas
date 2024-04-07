'' examples/manual/strings/cvd.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CVD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvd
'' --------

Dim d As Double, l As LongInt
d = 1.125
l = CVLongInt(d)

Print Using "l = _&H&"; Hex(l)
Print Using "cvd(i) = &"; CVD(l)
