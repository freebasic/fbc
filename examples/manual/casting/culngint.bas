'' examples/manual/casting/culngint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CULNGINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCulngint
'' --------

' Using the CLNGINT function to convert a numeric value

'Create an UNSIGNED LONG INTEGER variable
Dim numeric_value As ULongInt

'Convert a numeric value
numeric_value = CULngInt(12345678.123)

'Print the result, should return 12345678
Print numeric_value
Sleep
