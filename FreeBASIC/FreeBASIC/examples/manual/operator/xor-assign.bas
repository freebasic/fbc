'' examples/manual/operator/xor-assign.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineXor
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Xor= b
'' Result    a = &b01100110
Print Bin(a)
