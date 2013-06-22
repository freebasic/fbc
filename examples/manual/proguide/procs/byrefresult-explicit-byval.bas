'' examples/manual/proguide/procs/byrefresult-explicit-byval.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgReturnValue
'' --------

Dim Shared i As Integer = 123

Function f( ) ByRef As Integer
	Dim pi As Integer Ptr = @i

	Function = ByVal pi

	'' or, with RETURN it would look like this:
	Return ByVal pi
End Function

Print i, f( )
