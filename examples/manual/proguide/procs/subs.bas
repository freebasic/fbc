'' examples/manual/proguide/procs/subs.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Procedures Overview'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedures
'' --------

' introduces the sub 'MyProcedure'
Declare Sub MyProcedure

' calls the procedure 'MyProcedure'
MyProcedure

' defines the procedure body for 'MyProcedure'
Sub MyProcedure
	Print "the body of MyProcedure"
End Sub
