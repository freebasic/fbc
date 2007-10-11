'' examples/manual/operator/imp-bitwise.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpImp
'' --------

Dim As UByte a, b, c
a = &b00001111
b = &b01010101
c = a Imp b '' c = &b11110101
