'' examples/manual/array/size.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ARRAYSIZE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgArraySize
'' --------

#include Once "fbc-int/array.bi"
Using FB

Dim As LongInt array(4, 5)
Dim As UInteger array_size

array_size = ArraySize(array())
Print array_size                 '' 240
