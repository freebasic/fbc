'' examples/manual/proguide/procptrs/alias.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedurePOinters
'' --------

'' .. Add and pFunc as before ..
#include once "pfunc.bi"

Type operation As Function (As Integer, As Integer) As Integer

Function DoOperation (a As Integer, b As Integer, op As operation) As Integer
	Return op(a, b)
End Function

Print "3 + 4 = " & DoOperation(3, 4, @Add)
