'' examples/manual/casting/cshort.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CSHORT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCshort
'' --------

' Using the CSHORT function to convert a numeric value

'Create an SHORT variable
Dim numeric_value As Short

'Convert a numeric value
numeric_value = CShort(-4500.66)

'Print the result, should return -4501
Print numeric_value
Sleep
