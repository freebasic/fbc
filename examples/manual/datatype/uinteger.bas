'' examples/manual/datatype/uinteger.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UINTEGER'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUinteger
'' --------

#ifdef __FB_64BIT__
	Dim x As UInteger = 0
	Dim y As UInteger = &HFFFFFFFFFFFFFFFF
	Print "UInteger Range = "; x; " to "; y
#else
	Dim x As UInteger = 0
	Dim y As UInteger = &HFFFFFFFF
	Print "UInteger Range = "; x; " to "; y
#endif
