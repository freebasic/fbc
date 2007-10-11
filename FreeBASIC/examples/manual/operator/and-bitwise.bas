'' examples/manual/operator/and-bitwise.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAnd
'' --------

' Using the AND operator on two numeric values
Dim As UByte numeric_value1, numeric_value2
numeric_value1 = 15 '00001111
numeric_value2 = 30 '00011110

'Result =  14  =     00001110
Print numeric_value1 And numeric_value2
Sleep
