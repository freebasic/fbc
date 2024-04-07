'' examples/manual/udt/baseinit1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BASE (initializer)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBaseInit
'' --------

Type SimpleParent
	As Integer a, b, c
End Type

Type Child Extends SimpleParent
	Declare Constructor( )
End Type

Constructor Child( )
	'' Simple UDT initializer
	Base( 1, 2, 3 )
End Constructor
