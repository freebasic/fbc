'' examples/manual/datatype/integer.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInteger
'' --------

#ifdef __FB_64BIT__
	Dim x As Integer = &H8000000000000000
	Dim y As Integer = &H7FFFFFFFFFFFFFFF
	Print "Integer Range = "; x; " to "; y
#else
	Dim x As Integer = &H80000000
	Dim y As Integer = &H7FFFFFFF
	Print "Integer Range = "; x; " to "; y
#endif
