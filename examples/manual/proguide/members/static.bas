'' examples/manual/proguide/members/static.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Member Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

Type foo
	Declare Static Sub f (ByRef As foo)

	i As Integer
End Type

Sub foo.f (ByRef self As foo)
	'' Ok, self is an instance of foo:
	Print self.i

	'' would cause error
	'' cannot access non-static members, no foo instance:
	'' Print i
End Sub
