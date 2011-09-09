'' examples/manual/dates/timer.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTimer
'' --------

'' Example of using TIMER function 
'' Note: see text about correct waiting strategies
Dim Start As Double
Print "Wait 2.5 seconds."
Start = Timer
Do
	Sleep 1, 1
Loop Until (Timer - Start) > 2.5
Print "Done."
