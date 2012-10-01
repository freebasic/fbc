'' examples/manual/udt/baseinit1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBaseInit
'' --------

Type SimpleParent
	As Integer a, b, c
End Type

Type Child extends SimpleParent
	Declare Constructor( )
End Type

Constructor Child( )
	'' Simple UDT initializer
	Base( 1, 2, 3 )
End Constructor
