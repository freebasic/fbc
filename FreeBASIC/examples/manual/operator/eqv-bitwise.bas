'' examples/manual/operator/eqv-bitwise.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpEqv
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101, c
c = a Eqv b '' c = &b10011001
