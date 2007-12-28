'' examples/manual/casting/culng.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCulng
'' --------

' Using the CULNG function to convert a numeric value

'Create an UNSIGNED LONG variable
Dim numeric_value As ULONG

'Convert a numeric value
numeric_value = CULng(300.23)

'Print the result = 300
Print numeric_value
Sleep
