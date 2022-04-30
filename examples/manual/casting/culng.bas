'' examples/manual/casting/culng.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CULNG'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCulng
'' --------

' Using the CULNG function to convert a numeric value

'Create an UNSIGNED LONG variable
Dim numeric_value As ULong

'Convert a numeric value
numeric_value = CULng(300.23)

'Print the result = 300
Print numeric_value
Sleep
