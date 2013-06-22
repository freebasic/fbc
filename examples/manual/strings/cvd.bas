'' examples/manual/strings/cvd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvd
'' --------

Dim d As Double, l As LongInt
d = 1.125
l = CVLongInt(d)

Print Using "l = _&H&"; Hex(l)
Print Using "cvd(i) = &"; CVD(l)
