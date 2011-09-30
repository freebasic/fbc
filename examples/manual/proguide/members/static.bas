'' examples/manual/proguide/members/static.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
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
