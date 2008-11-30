'' examples/manual/strings/wspace.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWspace
'' --------

Dim a As WString * 10
a = "x" + WSpace(3) + "x"
Print a ' prints: x   x
