'' examples/manual/proguide/multithreading/criticalsectionfaq9-5.bas
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
Dim Shared mutex As Any Ptr

Sub thread1 (ByVal param As Any Ptr)   
	ScreenSet 1, 0
	Do
		MutexLock(mutex)
		Line (16, 432)-Step(96, 16), 11, BF  'clear the print area
		Sleep 200, 1
		Draw String (24, 432), Format(Now,"dd/mm/yyyy"), 0
		ScreenCopy
		MutexUnlock(mutex)
		Sleep 100, 1
	Loop Until terminate = 1
End Sub

Sub thread2 (ByVal param As Any Ptr)   
	ScreenSet 1, 0
	Do
		MutexLock(mutex)
		Line (16, 448)-Step(96, 16), 11, BF  'clear the print area
		Sleep 100, 1
		Draw String (32, 448), Format(Now,"hh:mm:ss"), 0
		ScreenCopy
		MutexUnlock(mutex)
		Sleep 100, 1
	Loop Until terminate = 1
End Sub

Dim As String reply
Locate 2, 2
Print "Enter ""quit"" to quit"
ScreenCopy

mutex = MutexCreate
Dim p1 As Any Ptr = ThreadCreate(@thread1)
Dim p2 As Any Ptr = ThreadCreate(@thread2)

Do
	Locate 3, 2
	Print Space(Len(reply) + 2);
	Locate 3, 2
	Input reply
Loop Until LCase(reply) = "quit"

Print " Stop the threads"
ScreenCopy
terminate=1
ThreadWait (p1)
ThreadWait (p2)
MutexDestroy(mutex)
Print " Threads terminated"
ScreenCopy

Sleep
					
