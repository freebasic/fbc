'' examples/manual/proguide/typalias/procptr_1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeAliases
'' --------

Declare Function f (ByRef As String) As Integer

Type func_t As Function (ByRef As String) As Integer

Dim func As func_t = @f
		
Function f (Byref arg as String) as Integer
	Function = Cint(arg)
End Function
