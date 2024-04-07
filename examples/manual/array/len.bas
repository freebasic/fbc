'' examples/manual/array/len.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ARRAYLEN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgArrayLen
'' --------

#include Once "fbc-int/array.bi"
Using FB

Dim As LongInt array(4, 5)
Dim As UInteger array_length

array_length = ArrayLen(array())
Print array_length                '' 30
