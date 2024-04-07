'' examples/manual/proguide/multithreading/mutualexclusion2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Mutual Exclusion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtMutualExclusion
'' --------

'  Principle of mutual exclusion
'      Main thread                      XOR            Child thread
'  .....                                           .....
'  MUTEXLOCK(mutID)                                MUTEXLOCK(mutID)
'      Do_something_with_exclusion                     Do_something_with_exclusion
'  MUTEXUNLOCK(mutID)                              MUTEXUNLOCK(mutID)
'  .....                                           .....


Declare Sub thread (ByVal userdata As Any Ptr)

Dim As Any Ptr threadID      '' declaration of an 'Any Ptr' thread-ID of the child thread
Dim Shared As Any Ptr mutID  '' declaration of a global 'Any Ptr' mutex-ID
	mutID = MutexCreate      '' creation of the mutex


Print """[M]"": from 'Main' thread"
Print """(C)"": from 'Child' thread"
Print

threadID = ThreadCreate(@thread)  '' creation of the child thread from the main thread

For I As Integer = 1 To 10  '' 'For' loop of the main thread
	MutexLock(mutID)        '' set mutex locked at the beginning of the exclusive section
	Print "[";
	Sleep 50, 1
	Print "M";
	Sleep 50, 1
	Print "]";
	MutexUnlock(mutID)      '' set mutex unlocked at the end of the exclusive section
	Sleep 50, 1
Next I

ThreadWait(threadID)  '' waiting for the child thread termination
Print
Print "'Child' thread finished"

MutexDestroy(mutID)  '' destruction of the mutex

Sleep


Sub thread (ByVal userdata As Any Ptr)  '' sub executed by the child thread
	For I As Integer = 1 To 10          '' 'For' loop of the child thread
		MutexLock(mutID)                '' set mutex locked at the beginning of the exclusive section
		Print "(";
		Sleep 50, 1
		Print "C";
		Sleep 50, 1
		Print ")";
		MutexUnlock(mutID)              '' set mutex unlocked at the end of the exclusive section
		Sleep 250, 1
	Next I
End Sub
		
