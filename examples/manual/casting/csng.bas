'' examples/manual/casting/csng.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CSNG'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCsng
'' --------

' Using the CSNG function to convert a numeric value

'Create an SINGLE variable
Dim numeric_value As Single

'Convert a numeric value
numeric_value = CSng(-12345.123)

'Print the result, should return -12345.123
Print numeric_value
Sleep
