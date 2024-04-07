'' examples/manual/operator/and-bitwise.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator AND (Conjunction)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAnd
'' --------

' Using the AND operator on two numeric values
Dim As UByte numeric_value1, numeric_value2
numeric_value1 = 15 '00001111
numeric_value2 = 30 '00011110

'Result =  14  =     00001110
Print numeric_value1 And numeric_value2
Sleep
