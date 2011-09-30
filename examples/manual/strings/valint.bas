'' examples/manual/strings/valint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgValint
'' --------

Dim a As String, b As Integer
a = "20xa211"
b = ValInt(a)
Print a, b
