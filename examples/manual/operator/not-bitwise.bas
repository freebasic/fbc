'' examples/manual/operator/not-bitwise.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNot
'' --------

' Using the NOT operator on a numeric value

Dim numeric_value As Byte
numeric_value = 15 '00001111

'Result = -16 =     11110000
Print Not numeric_value
