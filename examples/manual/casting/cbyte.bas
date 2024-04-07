'' examples/manual/casting/cbyte.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CBYTE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCbyte
'' --------

' Using the CBYTE function to convert a numeric value

'Create an BYTE variable
Dim numeric_value As Byte

'Convert a numeric value
numeric_value = CByte(-66.30)

'Print the result, should return -66
Print numeric_value
Sleep
