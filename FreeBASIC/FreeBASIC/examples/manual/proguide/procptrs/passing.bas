'' examples/manual/proguide/procptrs/passing.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePOinters
'' --------

'' .. Add and pFunc as before ..
#include once "pfunc.bi"

Function DoOperation (a As Integer, b As Integer, operation As Function (As Integer, As Integer) As Integer) As Integer
	Return operation(a, b)
End Function

Print "3 + 4 = " & DoOperation(3, 4, @Add)
