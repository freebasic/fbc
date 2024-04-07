'' examples/manual/proguide/members/this.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Member Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
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
