'' examples/manual/casting/cushort.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CUSHORT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCushort
'' --------

' Using the CUSHORT function to convert a numeric value

'Create an USHORT variable
Dim numeric_value As UShort

'Convert a numeric value
numeric_value = CUShort(36000.4)

'Print the result, should return 36000
Print numeric_value
Sleep
