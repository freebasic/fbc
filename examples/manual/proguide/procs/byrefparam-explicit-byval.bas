'' examples/manual/proguide/procs/byrefparam-explicit-byval.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Passing Arguments to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArguments
'' --------

Sub f( ByRef i As Integer )
	i = 456
End Sub

Dim i As Integer = 123
Dim pi As Integer Ptr = @i

Print i
f( ByVal pi )
Print i
