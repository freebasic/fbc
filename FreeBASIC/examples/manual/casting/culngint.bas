'' examples/manual/casting/culngint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCulngint
'' --------

' Using the CLNGINT function to convert a numeric value

'Create an UNSIGNED LONG INTEGER variable
Dim numeric_value As ULongInt

'Convert a numeric value
numeric_value = CULngInt(12345678.123)

'Print the result, should return 12345678
Print numeric_value
Sleep
