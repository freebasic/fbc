'' examples/manual/proguide/procptrs/passing.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'' .. Add and pFunc as before ..
#include Once "pfunc.bi"

Function DoOperation (a As Integer, b As Integer, operation As Function (As Integer, As Integer) As Integer) As Integer
	Return operation(a, b)
End Function

Print "3 + 4 = " & DoOperation(3, 4, @Add)
		
