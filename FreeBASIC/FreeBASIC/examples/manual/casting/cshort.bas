'' examples/manual/casting/cshort.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCshort
'' --------

' Using the CSHORT function to convert a numeric value

'Create an SHORT variable
Dim numeric_value As Short

'Convert a numeric value
numeric_value = CShort(-4500.66)

'Print the result, should return -4501
Print numeric_value
Sleep
