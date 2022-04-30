'' examples/manual/casting/cint.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CINT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCint
'' --------

' Using the CINT function to convert a numeric value

'Create an INTEGER variable
Dim numeric_value As Integer

'Convert a numeric value
numeric_value = CInt(300.5)

'Print the result, should return 300, because 300 is even

numeric_value = CInt(301.5)

'Print the result, should return 302, because 301 is odd
Print numeric_value
