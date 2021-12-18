'' examples/manual/array/size.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgArraySize
'' --------

#include Once "fbc-int/array.bi"
Using FB

Dim As LongInt array(4, 5)
Dim As UInteger array_size

array_size = ArraySize(array())
Print array_size                 '' 240
