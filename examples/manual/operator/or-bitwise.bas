'' examples/manual/operator/or-bitwise.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator OR (Inclusive Disjunction)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpOr
'' --------

' Using the OR operator on two numeric values
Dim As UByte numeric_value1, numeric_value2
numeric_value1 = 15 '00001111
numeric_value2 = 30 '00011110

'Result =  31  =     00011111       
Print numeric_value1 Or numeric_value2
Sleep
