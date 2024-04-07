'' examples/manual/proguide/multithreading/mutualexclusion1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Mutual Exclusion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtMutualExclusion
'' --------

Declare Sub thread (ByVal userdata As Any Ptr)

Dim As Any Ptr threadID  '' declaration of an 'Any Ptr' thread-ID of the child thread


Print """[M]"": from 'Main' thread"
Print """(C)"": from 'Child' thread"
Print

threadID = ThreadCreate(@thread)  '' creation of the child thread from the main thread

For I As Integer = 1 To 10  '' 'For' loop of the main thread
	Print "[";
	Sleep 50, 1
	Print "M";
	Sleep 50, 1
	Print "]";
	Sleep 50, 1
Next I

ThreadWait(threadID)  '' waiting for the child thread termination
Print
Print "'Child' thread finished"

Sleep


Sub thread (ByVal userdata As Any Ptr)  '' sub executed by the child thread
	For I As Integer = 1 To 10          '' 'For' loop of the child thread
		Print "(";
		Sleep 50, 1
		Print "C";
		Sleep 50, 1
		Print ")";
		Sleep 250, 1
	Next I
End Sub
		
