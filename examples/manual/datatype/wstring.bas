'' examples/manual/datatype/wstring.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WSTRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWstring
'' --------

Dim As WString * 13 str1 => "hello, world"
Print str1
Print Len(str1)    'returns 12, the length of the string it contains 
Print SizeOf(str1) 'returns 13 * sizeof(wstring), the number of bytes used by the variable
