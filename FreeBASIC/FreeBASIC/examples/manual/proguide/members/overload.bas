'' examples/manual/proguide/members/overload.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

Type T
	Declare Sub f
	
	'' Different number of parameters:
	Declare Sub f (As Integer)
	
	'' Different type of parameters:
	Declare Sub f (ByRef As String)
	
	'' Again, parameters are different:
	Declare Function f (As UByte) As Integer
	
	'' following three members would cause an error,
	'' number of parameters and/or types do not differ:

	'' Declare Function f As Integer
	'' Declare Function f (As UByte) As String
	'' Declare Static Function f (As UByte) As Integer

	'' ...
	somedata as any ptr
End Type
