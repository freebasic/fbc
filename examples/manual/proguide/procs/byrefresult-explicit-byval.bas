'' examples/manual/proguide/procs/byrefresult-explicit-byval.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Returning Values'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReturnValue
'' --------

Dim Shared i As Integer = 123

Function f( ) ByRef As Integer
	Dim pi As Integer Ptr = @i

	Function = ByVal pi

	'' or, with RETURN it would look like this:
	Return ByVal pi
End Function

Print i, f( )
