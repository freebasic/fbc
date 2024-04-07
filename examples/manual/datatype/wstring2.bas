'' examples/manual/datatype/wstring2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WSTRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWstring
'' --------

Dim As WString Ptr str2
str2 = Allocate( 13 * Len(WString) )
*str2 = "hello, world"
Print *str2
Print Len(*str2)      'returns 12, the length of the string it points to
