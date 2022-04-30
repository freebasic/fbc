'' examples/manual/proguide/multithreading/thread2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Threads'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtThreads
'' --------

#include "fbthread.bi"

Declare Sub thread (ByVal userdata As Any Ptr)

Dim As Any Ptr threadID          '' declaration of an 'Any Ptr' thread-ID of the child thread
Dim Shared As Boolean threadEnd  '' declaration of a global 'Boolean' thread-End flag for the child thread


Print """M"": from 'Main' thread"
Print """C"": from 'Child' thread"
Print

threadID = ThreadCreate(@thread)  '' creation of the child thread from the main thread
ThreadDetach(threadID)            '' detaching the child thread

For I As Integer = 1 To 10  '' 'For' loop of the main thread
	Print "M";
	Sleep 150, 1
Next I

While threadEnd = False  '' waiting for the thread-End flag = 'True' from the child thread
Wend
Print
Print "'Child' thread finishing or finished"

Sleep


Sub thread (ByVal userdata As Any Ptr)  '' sub executed by the child thread
	For I As Integer = 1 To 10          '' 'For' loop of the child thread
		Print "C";
		Sleep 350, 1
	Next I
	threadEnd = True                    '' set the thrend-End flag to 'True'
End Sub
			
