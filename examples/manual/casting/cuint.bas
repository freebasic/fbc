'' examples/manual/casting/cuint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CUINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCuint
'' --------

' Using the CUINT function to convert a numeric value

'Create an UNSIGNED INTEGER variable
Dim numeric_value As UInteger

'Convert a numeric value
numeric_value = CUInt(300.23)

'Print the result = 300
Print numeric_value
