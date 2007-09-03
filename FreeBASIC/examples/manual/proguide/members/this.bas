'' examples/manual/proguide/members/this.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

Type foo
	Declare Sub f (i As Integer)
	Declare Sub g ()

	i As Integer = 420
End Type

Sub foo.f (i As Integer)
	'' A parameter hides T.i, so it needs to be qualified to be used:
	Print this.i
End Sub

Sub foo.g ()
	'' A local variable hides T.i, so it needs to be qualified to be used:
	Dim i As Integer
	Print this.i
End Sub
