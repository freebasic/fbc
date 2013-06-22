'' examples/manual/datatype/uinteger.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUinteger
'' --------

#if __FB_64BIT__
	Dim x As UInteger = 0
	Dim y As UInteger = &HFFFFFFFFFFFFFFFF
	Print "UInteger Range = "; x; " to "; y
#else
	Dim x As UInteger = 0
	Dim y As UInteger = &HFFFFFFFF
	Print "UInteger Range = "; x; " to "; y
#endif
