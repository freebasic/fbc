'' examples/manual/casting/cdbl.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCdbl
'' --------

' Using the CDBL function to convert a numeric value

'Create an DOUBLE variable
Dim numeric_value As Double

'Convert a numeric value
numeric_value = CDbl(-12345678.123)

'Print the result, should return -12345678.123
Print numeric_value
Sleep
