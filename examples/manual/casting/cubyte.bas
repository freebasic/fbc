'' examples/manual/casting/cubyte.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCubyte
'' --------

' Using the CUBYTE function to convert a numeric value

'Create an UNSIGNED BYTE variable
Dim numeric_value As UByte

'Convert a numeric value
numeric_value = CUByte(123.55)

'Print the result, should return 124
Print numeric_value
Sleep
