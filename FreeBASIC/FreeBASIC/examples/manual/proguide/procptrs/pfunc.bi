'' examples/manual/proguide/procptrs/pfunc.bi
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePOinters
'' --------

Function Add (a As Integer, b As Integer) As Integer
	Return a + b
End Function

Dim pFunc As Function (As Integer, As Integer) As Integer = @Add
