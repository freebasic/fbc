'' examples/manual/strings/cvd.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCvd
'' --------

Dim a As Double, b As String
a=4534.4243
b=MKD(a)
Print a, CVD(b)
Sleep
