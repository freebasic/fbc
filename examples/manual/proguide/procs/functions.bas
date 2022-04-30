'' examples/manual/proguide/procs/functions.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Procedures Overview'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedures
'' --------

' introduces and defines a procedure that returns an integer value
Function MyProcedure As Integer
	Return 10
End Function

' calls the procedure, and stores its return value in a variable
Dim i As Integer = MyProcedure
Print i
