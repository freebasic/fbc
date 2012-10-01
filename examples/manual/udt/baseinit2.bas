'' examples/manual/udt/baseinit2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBaseInit
'' --------

Type ComplexParent
	As Integer i
	Declare Constructor( ByVal As Integer )
End Type

Constructor ComplexParent( ByVal i As Integer )
	this.i = i
End Constructor

Type Child extends ComplexParent
	Declare Constructor( )
	Declare Constructor( ByRef As Child )
End Type

Constructor Child( )
	'' Base UDT constructor call
	Base( 1 )
End Constructor

Constructor Child( ByRef rhs As Child )
	'' Base UDT constructor call
	Base( rhs.i )
End Constructor
