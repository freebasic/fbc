'' examples/manual/udt/override.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOverride
'' --------

Type A extends object
	Declare virtual Sub f1( )
	Declare virtual Function f2( ) As Integer
End Type

Type B extends A
	Declare Sub f1( ) override
	Declare Function f2( ) As Integer override
End Type

'' Note: define four procedure bodies to compile without error
