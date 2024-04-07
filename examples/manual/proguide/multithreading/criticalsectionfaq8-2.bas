'' examples/manual/proguide/multithreading/criticalsectionfaq8-2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

#include "vbcompat.bi"

Screen 12, , 2
ScreenSet 1, 0   
Color 0, 7
Cls

Dim Shared terminate As Integer = 0

Sub thread (ByVal param As Any Ptr)   
	ScreenSet 1, 0
	Do
		Line (16, 432)-Step(96, 32), 11, BF  'clear print area
		Sleep 100, 1
		Draw String (24, 432), Format(Now,"dd/mm/yyyy"), 0
		Draw String (32, 448), Format(Now,"hh:mm:ss"), 0
		ScreenCopy
		Sleep 100, 1
	Loop Until terminate = 1
End Sub

Dim As String reply
Locate 2, 2
Print "Enter ""q"" to quit"
ScreenCopy

Dim p As Any Ptr = ThreadCreate(@thread)

Do
	reply = Inkey
	Sleep 100, 1
Loop Until LCase(reply) = "q"

Print " Stop the thread"
ScreenCopy
terminate=1
ThreadWait (p)
Print " Thread terminated"
ScreenCopy

Sleep
				
