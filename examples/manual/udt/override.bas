'' examples/manual/udt/override.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOverride
'' --------

Type A Extends Object
	Declare Virtual Sub f1( )
	Declare Virtual Function f2( ) As Integer
End Type

Type B Extends A
	Declare Sub f1( ) Override
	Declare Function f2( ) As Integer Override
End Type

Sub A.f1( )
End Sub

Function A.f2( ) As Integer
	Function = 0
End Function

Sub B.f1( )
End Sub

Function B.f2( ) As Integer
	Function = 0
End Function
