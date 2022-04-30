'' examples/manual/datatype/zstring.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ZSTRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgZstring
'' --------

Dim As ZString * 13 str1 => "hello, world"
Print str1
Print Len(str1)     'returns 12, the size of the string it contains 
Print SizeOf(str1)  'returns 13, the size of the variable
