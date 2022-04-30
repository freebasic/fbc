'' examples/manual/operator/not-bitwise.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Not (Complement)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNot
'' --------

' Using the NOT operator on a numeric value

Dim numeric_value As Byte
numeric_value = 15 '00001111

'Result = -16 =     11110000
Print Not numeric_value
