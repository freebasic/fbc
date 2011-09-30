'' examples/manual/casting/clngint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgClngint
'' --------

' Using the CLNGINT function to convert a numeric value

'Create an LONG INTEGER variable
Dim numeric_value As LongInt

'Convert a numeric value
numeric_value = CLngInt(-12345678.123)

'Print the result, should return -12345678
Print numeric_value
Sleep
