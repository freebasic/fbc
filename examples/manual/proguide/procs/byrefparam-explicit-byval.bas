'' examples/manual/proguide/procs/byrefparam-explicit-byval.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArguments
'' --------

Sub f( ByRef i As Integer )
	i = 456
End Sub

Dim i As Integer = 123
Dim pi As Integer Ptr = @i

Print i
f( ByVal pi )
Print i
