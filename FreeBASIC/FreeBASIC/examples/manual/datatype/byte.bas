'' examples/manual/datatype/byte.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByte
'' --------

Dim x As Byte = CByte(&H80)
Dim y As Byte = CByte(&H7F)
Print "Byte Range = "; x; " to "; y
