'' examples/manual/proguide/procs/functions.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedures
'' --------

' introduces and defines a procedure that returns an integer value
Function MyProcedure As Integer
	Return 10
End Function

' calls the procedure, and stores its return value in a variable
Dim i As Integer = MyProcedure
Print i
