'' examples/manual/dates/timer.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TIMER'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTimer
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
