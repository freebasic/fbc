'' examples/manual/proguide/procptrs/pfunc.bi
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'' pfunc.bi

Function Add (a As Integer, b As Integer) As Integer
	Return a + b
End Function

Dim pFunc As Function (As Integer, As Integer) As Integer = @Add
		
