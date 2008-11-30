'' examples/manual/strings/val.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVal
'' --------

Dim a As String, b As Double
a = "2.1E+30xa211"
b = Val(a)
Print a, b
