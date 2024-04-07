'' examples/manual/datatype/integer.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INTEGER'
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
