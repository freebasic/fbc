'' examples/manual/control/iif.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgIif
'' --------

Dim As Integer a, b, x, y, z
a = (x + y + IIf(b > 0, 4, 7)) \ z
