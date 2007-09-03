'' examples/manual/proguide/members/foo2.bi
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

'' foo2.bi

Type foo
	Declare Static Sub f (As Integer)
	Declare Static Function g As Integer

	i As Integer
End Type

Static Sub foo.f (n As Integer) Static
	Print n
End Sub
	
Function foo.g As Integer
	Return 420
End Function
