'' examples/manual/datatype/zstring2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgZstring
'' --------

Dim As ZString Ptr str2
str2 = Allocate( 13 )
*str2 = "hello, world"
Print *str2
Print Len(*str2)     'returns 12, the size of the string it contains 
