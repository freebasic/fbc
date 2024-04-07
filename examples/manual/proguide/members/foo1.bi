'' examples/manual/proguide/members/foo1.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Member Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

'' foo1.bi

Type foo
	Declare Sub f (As Integer)
	Declare Function g As Integer

	i As Integer
End Type

Sub foo.f (n As Integer)
	Print n
End Sub

Function foo.g As Integer
	Return 420
End Function
