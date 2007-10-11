'' examples/manual/casting/cushort.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCushort
'' --------

' Using the CUSHORT function to convert a numeric value

'Create an USHORT variable
Dim numeric_value As UShort

'Convert a numeric value
numeric_value = CUShort(36000.4)

'Print the result, should return 36000
Print numeric_value
Sleep
