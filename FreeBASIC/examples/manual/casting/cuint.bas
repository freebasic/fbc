'' examples/manual/casting/cuint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCuint
'' --------

' Using the CUINT function to convert a numeric value

'Create an UNSIGNED INTEGER variable
Dim numeric_value As UInteger

'Convert a numeric value
numeric_value = CUInt(300.23)

'Print the result = 300
Print numeric_value
Sleep
