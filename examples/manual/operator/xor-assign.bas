'' examples/manual/operator/xor-assign.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator XOR= (Exclusive Disjunction and Assign)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineXor
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Xor= b
'' Result    a = &b01100110
Print Bin(a)
