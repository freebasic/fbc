'' examples/manual/operator/or-assign.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineOr
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Or= b
'' Result    a = &b01110111
Print Bin(a)
