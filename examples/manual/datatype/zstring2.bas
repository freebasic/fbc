'' examples/manual/datatype/zstring2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ZSTRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgZstring
'' --------

Dim As ZString Ptr str2
str2 = Allocate( 13 )
*str2 = "hello, world"
Print *str2
Print Len(*str2)     'returns 12, the size of the string it contains 
