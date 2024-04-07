'' examples/manual/proguide/procptrs/alias.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Pointers to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePointers
'' --------

'' .. Add and pFunc as before ..
#include Once "pfunc.bi"

Type operation As Function (As Integer, As Integer) As Integer

Function DoOperation (a As Integer, b As Integer, op As operation) As Integer
	Return op(a, b)
End Function

Print "3 + 4 = " & DoOperation(3, 4, @Add)
		
