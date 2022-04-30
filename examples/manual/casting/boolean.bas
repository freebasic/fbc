'' examples/manual/casting/boolean.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CBOOL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCbool
'' --------

' Using the CBOOL function to convert a numeric value

'Create an BOOLEAN variable
Dim b As Boolean

'Convert a numeric value
b = CBool(1)

'Print the result, should return True
Print b
Sleep
