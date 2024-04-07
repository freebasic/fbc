'' examples/manual/casting/cdbl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CDBL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCdbl
'' --------

' Using the CDBL function to convert a numeric value

'Create an DOUBLE variable
Dim numeric_value As Double

'Convert a numeric value
numeric_value = CDbl(-12345678.123)

'Print the result, should return -12345678.123
Print numeric_value
Sleep
