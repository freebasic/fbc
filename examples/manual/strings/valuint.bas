'' examples/manual/strings/valuint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgValuint
'' --------

Dim a As String, b As UInteger
a = "20xa211"
b = ValUInt(a)
Print a, b
