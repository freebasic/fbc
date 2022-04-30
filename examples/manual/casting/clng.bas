'' examples/manual/casting/clng.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CLNG'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgClng
'' --------

' Using the CLNG function to convert a numeric value

'Create an LONG variable
Dim numeric_value As Long

'Convert a numeric value
numeric_value = CLng(-300.23)

'Print the result, should return -300
Print numeric_value
Sleep
