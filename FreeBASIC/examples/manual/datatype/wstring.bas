'' examples/manual/datatype/wstring.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWstring
'' --------

Dim As WString * 14 str1 => "hello, world"
Print str1
Print Len(str1)    'returns 12, the length of the string it contains 
Print SizeOf(str1) 'returns 14 * sizeof(wstring), the number of bytes used by the variable
