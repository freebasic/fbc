'' examples/manual/proguide/procs/subs.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgProcedures
'' --------

' introduces the sub 'MyProcedure'
Declare Sub MyProcedure

' calls the procedure 'MyProcedure'
MyProcedure

' defines the procedure body for 'MyProcedure'
Sub MyProcedure
	Print "the body of MyProcedure"
End Sub
