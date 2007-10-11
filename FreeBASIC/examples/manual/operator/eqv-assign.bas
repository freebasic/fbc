'' examples/manual/operator/eqv-assign.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineEqv
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Eqv= b
'' Result    a = &b10011001
Print Bin(a)
