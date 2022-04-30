'' examples/manual/proguide/members/foo2.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Member Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
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
